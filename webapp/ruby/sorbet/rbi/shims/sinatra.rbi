# typed: true

class Sinatra::Base
  class << self
    sig {
      params(
        path: String,
        opts: T.untyped,
        block: T.proc.bind(T.attached_class).void
      ).void
    }
    def get(path, opts = T.unsafe(nil), &block); end

    sig {
      params(
        path: String,
        opts: T.untyped,
        block: T.proc.bind(T.attached_class).void
      ).void
    }
    def post(path, opts = T.unsafe(nil), &block); end

    sig {
      params(
        extensions: Module,
        block: T.nilable(T.proc.bind(T.attached_class).void),
      ).void
    }
    def helpers(*extensions, &block); end

    sig {
      params(
        codes: T::Class[Exception],
        block: T.proc.bind(T.attached_class).void
      ).void
    }
    def error(*codes, &block); end
  end
end

module Sinatra::JSON
  # source://sinatra-contrib//lib/sinatra/json.rb#96
  sig {
    params(
      object: T.untyped,
      options: T.untyped,
    ).returns(String)
  }
  def json(object, options = T.unsafe(nil)); end
end
