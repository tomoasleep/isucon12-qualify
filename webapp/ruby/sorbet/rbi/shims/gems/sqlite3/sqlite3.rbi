# typed: true

class SQLite3::Database
  # https://github.com/sparklemotion/sqlite3-ruby/blob/v1.6.7/lib/sqlite3/database.rb#L181
  sig {
    params(
      sql: String,
      bind_vars: T.nilable(T::Array[T.untyped]),
      args: T.untyped,
      block:
        T.nilable(T.proc.params(arg0:
          # Returns HashWithTypesAndFields Database#results_as_hash is true
          # https://github.com/sparklemotion/sqlite3-ruby/blob/v1.6.7/lib/sqlite3/resultset.rb#L87-L88
          SQLite3::ResultSet::HashWithTypesAndFields
        ).void
      ),
    ).returns(
      T::Array[SQLite3::ResultSet::HashWithTypesAndFields]
      )
  }
  def execute(sql, bind_vars = [], *args, &block); end

  # https://github.com/sparklemotion/sqlite3-ruby/blob/v1.6.7/lib/sqlite3/database.rb#L144-L158
  sig {
    params(
      sql: String,
    ).returns(
      SQLite3::Statement
    )
  }
  sig {
    type_parameters(:T).params(
      sql: String,
      block:
        T.proc.params(
          arg0: SQLite3::Statement
        ).returns(T.type_parameter((:T))),
    ).returns(
      T.type_parameter(:T)
    )
  }
  def prepare(sql, &block); end

  # https://github.com/sparklemotion/sqlite3-ruby/blob/v1.6.7/lib/sqlite3/database.rb#L306-L341
  sig {
    params(
      sql: String,
      bind_vars: T.nilable(T::Array[T.untyped]),
      args: T.untyped,
    ).returns(
      SQLite3::ResultSet
    )
  }
  sig {
    type_parameters(:T).params(
      sql: String,
      bind_vars: T.nilable(T::Array[T.untyped]),
      args: T.untyped,
      block:
        T.proc.params(
          arg0: SQLite3::ResultSet
        ).returns(T.type_parameter((:T))),
    ).returns(
      T.type_parameter(:T)
    )
  }
  def query(sql, bind_vars = [], *args, &block); end
end

class Sqlite::Statement
  # https://github.com/sparklemotion/sqlite3-ruby/blob/v1.6.7/lib/sqlite3/statement.rb#L47-L71
  sig {
    params(
      bind_vars: T.untyped,
      block: T.nilable(
        T.proc.params(
          arg0: SQLite3::ResultSet,
        ).void
      )
    ).returns(
      SQLite3::ResultSet
    )
  }
  def execute(*bind_vars, &block); end
end
