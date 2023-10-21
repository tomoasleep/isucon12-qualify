# typed: true

class Mysql2::Client
  # source://mysql2//lib/mysql2/client.rb#146
  # https://github.com/brianmario/mysql2/blob/0.5.5/ext/mysql2/client.c#L843-L893
  sig {
    params(
      sql: String,
      options: T.untyped,
    ).returns(
      T.nilable(Mysql2::Result)
    )
  }
  def query(sql, options = T.unsafe(nil)); end
end

class Mysql2::Result
  # https://github.com/brianmario/mysql2/blob/0.5.5/ext/mysql2/result.c#L1058
  sig {
    params(
      args0: T.untyped,
      block: T.nilable(
        T.proc.params(
          # Returns Hash when asArray is false
          # https://github.com/brianmario/mysql2/blob/0.5.5/ext/mysql2/result.c#L1082
          # key is Symbol when symbolizeKeys is true
          # https://github.com/brianmario/mysql2/blob/0.5.5/ext/mysql2/result.c#L571C40-L571C40
          arg0: T::Hash[T.any(String, Symbol), T.untyped]
        ).void
      )
    ).returns(
      T::Array[T::Hash[T.any(String, Symbol), T.untyped]]
    )
  }
  def each(*args0, &block); end
end
