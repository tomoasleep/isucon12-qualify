# typed: true

require 'mustermann'

class RequestLogging
  def initialize(app, paths = [])
    @app = app
    @paths = paths.map { |path| Mustermann.new(path) }
  end

  def call(env)
    request = Rack::Request.new(env)

    status, headers, body = response = @app.call(env)

    if @paths.any? { |pattern| pattern.match(request.path) }
      response[2] = Rack::BodyProxy.new(body) do
        logger = request.logger
        next unless logger

        logger.info("RequestLogging (Path: #{request.path})") { body.to_s }
      end
    end

    response
  end
end
