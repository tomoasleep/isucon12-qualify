require 'pyroscope/otel'
require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require 'opentelemetry/instrumentation/all'

app_name = "isucon12q-practice"
pyroscope_url = ENV['AGENT_PYROSCOPE_URL']
otel_endpoint =

Pyroscope.configure do |config|
  config.application_name = app_name
  config.server_address = pyroscope_url

  config.basic_auth_username = ENV['AGENT_PYROSCOPE_USERNAME']
  config.basic_auth_password = ENV['AGENT_PYROSCOPE_PASSWORD']
end

OpenTelemetry::SDK.configure do |config|
  config.service_name = app_name

  config.add_span_processor Pyroscope::Otel::SpanProcessor.new(
    "#{app_name}.cpu", # your app name with ".cpu" suffix, for example rideshare-ruby.cpu
    pyroscope_url # link to your pyroscope server, for example "http://localhost:4040"
  )
  # Configure the rest of opentelemetry as described  https://github.com/open-telemetry/opentelemetry-ruby
  config.add_span_processor OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(OpenTelemetry::Exporter::OTLP::Exporter.new)

  config.use_all()
end
