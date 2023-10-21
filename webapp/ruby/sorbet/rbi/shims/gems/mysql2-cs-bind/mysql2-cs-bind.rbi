# typed: true

class Mysql2::Client
  # https://github.com/tagomoris/mysql2-cs-bind/blob/v0.1.1/lib/mysql2-cs-bind.rb#L7-L13
  sig {
    params(
      sql: String,
      args: T.untyped,
      options: T.untyped,
    ).returns(
      T.nilable(Mysql2::Result)
    )
  }
  def xquery(sql, *args, **options); end
end
