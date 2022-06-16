package bench

import (
	"context"
	"time"

	"github.com/isucon/isucandar"
	"github.com/isucon/isucandar/worker"
	"github.com/isucon/isucon12-qualify/data"
)

func (sc *Scenario) NewTenantScenarioWorker(step *isucandar.BenchmarkStep, p int32) (*worker.Worker, error) {
	w, err := worker.NewWorker(func(ctx context.Context, _ int) {
		if err := sc.NewTenantScenario(ctx, step); err != nil {
			AdminLogger.Printf("[NewTenantScenario] %v", err)
			time.Sleep(SleepOnError)
		}
	},
		worker.WithInfinityLoop(),
		worker.WithUnlimitedParallelism(),
	)
	if err != nil {
		return nil, err
	}
	w.SetParallelism(p)
	return w, nil
}

func (sc *Scenario) NewTenantScenario(ctx context.Context, step *isucandar.BenchmarkStep) error {
	report := timeReporter("新規テナントシナリオ")
	defer report()
	scTag := ScenarioTag("NewTenantScenario")
	AdminLogger.Printf("%s start\n", scTag)

	addPlayerTimes := 20 // PlayersAddを叩く回数
	addPlayerNum := 5    // 1度のPlayersAddで追加するプレイヤー数
	errorLimit := 30     // 許容するエラー数

	admin := &Account{
		Role:       AccountRoleAdmin,
		TenantName: "admin",
		PlayerID:   "admin",
		Option:     sc.Option,
	}
	if err := admin.SetJWT(sc.RawKey); err != nil {
		return err
	}
	adminAg, err := admin.GetAgent()
	if err != nil {
		return err
	}

	tenant := data.CreateTenant(false)
	res, err := PostAdminTenantsAddAction(ctx, tenant.Name, tenant.DisplayName, adminAg)
	v := ValidateResponse("新規テナント作成", step, res, err, WithStatusCode(200),
		WithSuccessResponse(func(r ResponseAPITenantsAdd) error {
			return nil
		}),
	)
	if v.IsEmpty() {
		sc.AddScoreByScenario(step, ScorePOSTAdminTenantsAdd, scTag)
	} else {
		return v
	}

	organizer := Account{
		Role:       AccountRoleOrganizer,
		TenantName: tenant.Name,
		PlayerID:   "organizer",
		Option:     sc.Option,
	}

	if err := organizer.SetJWT(sc.RawKey); err != nil {
		return err
	}
	orgAg, err := organizer.GetAgent()
	if err != nil {
		return err
	}

	// 参加者登録 addPlayerNum * addPlayerTimes
	players := make(map[string]*PlayerData, addPlayerNum*addPlayerTimes)
	{
		for times := 0; times < addPlayerTimes; times++ {
			playerDisplayNames := make([]string, addPlayerNum)
			for i := 0; i < addPlayerNum; i++ {
				playerDisplayNames = append(playerDisplayNames, data.RandomString(16))
			}
			res, err := PostOrganizerPlayersAddAction(ctx, playerDisplayNames, orgAg)
			v := ValidateResponse("大会参加者追加", step, res, err, WithStatusCode(200),
				WithSuccessResponse(func(r ResponseAPIPlayersAdd) error {
					for _, pl := range r.Data.Players {
						players[pl.DisplayName] = &PlayerData{
							ID:          pl.ID,
							DisplayName: pl.DisplayName,
						}
					}
					return nil
				}),
			)
			if v.IsEmpty() {
				sc.AddScoreByScenario(step, ScorePOSTOrganizerPlayersAdd, scTag)
			} else {
				return v
			}
		}
	}

	// 大会を1つ作成し、プレイヤーが登録し、リザルトを確認し続ける
	comp := &CompetitionData{
		Title: data.RandomString(24),
	}
	{
		res, err := PostOrganizerCompetitonsAddAction(ctx, comp.Title, orgAg)
		v := ValidateResponse("新規大会追加", step, res, err, WithStatusCode(200),
			WithSuccessResponse(func(r ResponseAPICompetitionsAdd) error {
				comp.ID = r.Data.Competition.ID
				return nil
			}))

		if v.IsEmpty() {
			sc.AddScoreByScenario(step, ScorePOSTOrganizerCompetitionsAdd, scTag)
		} else {
			return v
		}
	}

	// 大会のランキングを参照するプレイヤーたち
	// TODO: 要調整 一定回数見たらforを抜けて大会のcloseをしたいかも
	errorCount := 0
	for errorCount < errorLimit {
		for _, player := range players {
			if err := sc.tenantPlayerScenario(ctx, step, &tenantPlayerScenarioData{
				tenantName:    tenant.Name,
				playerID:      player.ID,
				competitionID: comp.ID,
			}); err != nil {
				// ctxが終了のエラーのみならループ終了
				if ve, ok := err.(ValidationError); ok && ve.Canceled {
					return nil
				}
				AdminLogger.Printf("[NewTenantScenario] %v", err)
				errorCount++
			}
		}
	}
	return nil

	// TODO: 一旦スキップ、この辺りはorganizer scenarioでも確認しているのでどこまでやるか
	// 大会結果入稿 x 1
	// {
	// 	var score ScoreRows
	// 	for _, player := range players {
	// 		score = append(score, &ScoreRow{
	// 			PlayerID: player.ID,
	// 			Score:    rand.Intn(1000),
	// 		})
	// 	}
	// 	csv := score.CSV()
	// 	res, err := PostOrganizerCompetitionResultAction(ctx, comp.ID, []byte(csv), orgAg)
	// 	v := ValidateResponse("大会結果CSV入稿", step, res, err, WithStatusCode(200),
	// 	WithSuccessResponse(func(r ResponseAPICompetitionResult) error {
	// 		_ = r
	// 		return nil
	// 	}),
	// )
	// if v.IsEmpty() {
	// 	sc.AddScoreByScenario(step, ScorePOSTOrganizerCompetitionResult, scTag)
	// } else {
	// 	return v
	// }

	// 大会結果確定 x 1
	// {
	// 	res, err := PostOrganizerCompetitionFinishAction(ctx, comp.ID, orgAg)
	// 	v := ValidateResponse("大会終了", step, res, err, WithStatusCode(200),
	// 	WithSuccessResponse(func(r ResponseAPICompetitionRankingFinish) error {
	// 		_ = r
	// 		return nil
	// 	})

	// 	if v.IsEmpty() {
	// 		sc.AddScoreByScenario(step, ScorePOSTOrganizerCompetitionFinish, scTag)
	// 	} else {
	// 		return v
	// 	}
	// }

	// 参加者を失格状態にする x N
	// {
	// 	index := 0
	// 	for _, player := range players {
	// 		// 5%の人は失格
	// 		index++
	// 		if index%100 > 5 {
	// 			continue
	// 		}
	// 		res, err := PostOrganizerApiPlayerDisqualifiedAction(ctx, player.ID, orgAg)
	// 		v := ValidateResponse("参加者を失格にする", step, res, err, WithStatusCode(200),
	// 			WithSuccessResponse(func(r ResponseAPIPlayerDisqualified) error {
	// 				_ = r
	// 				return nil
	// 			}),
	// 		)
	// 		if v.IsEmpty() {
	// 			sc.AddScoreByScenario(step, ScorePOSTOrganizerPlayerDisqualified, scTag)
	// 		} else {
	// 			return v
	// 		}
	// 	}
	// }

	// テナント請求ダッシュボードの閲覧 x 1
	// {
	// 	res, err := GetOrganizerBillingAction(ctx, orgAg)
	// 	v := ValidateResponse("テナント内の請求情報", step, res, err, WithStatusCode(200),
	// 		WithSuccessResponse(func(r ResponseAPIBilling) error {
	// 			_ = r
	// 			return nil
	// 		}),
	// 	)
	// 	if v.IsEmpty() {
	// 		sc.AddScoreByScenario(step, ScoreGETOrganizerBilling, scTag)
	// 	} else {
	// 		return v
	// 	}
	// }

	AdminLogger.Println("NewTenantScenario end")
	return nil
}

type tenantPlayerScenarioData struct {
	tenantName    string
	playerID      string
	competitionID string
}

func (sc *Scenario) tenantPlayerScenario(ctx context.Context, step *isucandar.BenchmarkStep, data *tenantPlayerScenarioData) error {
	scTag := ScenarioTag("NewTenantScenario")
	player := Account{
		Role:       AccountRolePlayer,
		TenantName: data.tenantName,
		PlayerID:   data.playerID,
		Option:     sc.Option,
	}
	if err := player.SetJWT(sc.RawKey); err != nil {
		return err
	}
	playerAg, err := player.GetAgent()
	if err != nil {
		return err
	}

	{
		res, err := GetPlayerAction(ctx, data.playerID, playerAg)
		v := ValidateResponse("参加者と戦績情報取得", step, res, err, WithStatusCode(200),
			WithSuccessResponse(func(r ResponseAPIPlayer) error {
				_ = r
				return nil
			}),
		)
		if v.IsEmpty() {
			sc.AddScoreByScenario(step, ScoreGETPlayerDetails, scTag)
		} else {
			return v
		}
	}
	{
		res, err := GetPlayerCompetitionRankingAction(ctx, data.competitionID, "", playerAg)
		v := ValidateResponse("大会内のランキング取得", step, res, err, WithStatusCode(200),
			WithSuccessResponse(func(r ResponseAPICompetitionRanking) error {
				_ = r
				return nil
			}),
		)
		if v.IsEmpty() {
			sc.AddScoreByScenario(step, ScoreGETPlayerRanking, scTag)
		} else {
			return v
		}
	}
	{
		res, err := GetPlayerCompetitionsAction(ctx, playerAg)
		v := ValidateResponse("テナント内の大会情報取得", step, res, err, WithStatusCode(200),
			WithSuccessResponse(func(r ResponseAPICompetitions) error {
				_ = r
				return nil
			}),
		)
		if v.IsEmpty() {
			sc.AddScoreByScenario(step, ScoreGETPlayerCompetitions, scTag)
		} else {
			return v
		}
	}

	return nil
}
