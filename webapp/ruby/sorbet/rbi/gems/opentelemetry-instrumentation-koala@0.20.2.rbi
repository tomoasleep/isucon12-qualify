# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `opentelemetry-instrumentation-koala` gem.
# Please instead update this file by running `bin/tapioca gem opentelemetry-instrumentation-koala`.

# OpenTelemetry is an open source observability framework, providing a
# general-purpose API, SDK, and related tools required for the instrumentation
# of cloud-native software, frameworks, and libraries.
#
# The OpenTelemetry module provides global accessors for telemetry objects.
# See the documentation for the `opentelemetry-api` gem for details.
#
# source://opentelemetry-instrumentation-koala//lib/opentelemetry/instrumentation.rb#13
module OpenTelemetry
  # source://opentelemetry-api/1.1.0/lib/opentelemetry.rb#36
  def error_handler; end

  # source://opentelemetry-api/1.1.0/lib/opentelemetry.rb#27
  def error_handler=(_arg0); end

  # source://opentelemetry-api/1.1.0/lib/opentelemetry.rb#44
  def handle_error(exception: T.unsafe(nil), message: T.unsafe(nil)); end

  # source://opentelemetry-api/1.1.0/lib/opentelemetry.rb#30
  def logger; end

  # source://opentelemetry-api/1.1.0/lib/opentelemetry.rb#27
  def logger=(_arg0); end

  # source://opentelemetry-api/1.1.0/lib/opentelemetry.rb#69
  def propagation; end

  # source://opentelemetry-api/1.1.0/lib/opentelemetry.rb#27
  def propagation=(_arg0); end

  # source://opentelemetry-api/1.1.0/lib/opentelemetry.rb#64
  def tracer_provider; end

  # source://opentelemetry-api/1.1.0/lib/opentelemetry.rb#52
  def tracer_provider=(provider); end
end

# Instrumentation should be able to handle the case when the library is not installed on a user's system.
#
# source://opentelemetry-instrumentation-koala//lib/opentelemetry/instrumentation.rb#15
module OpenTelemetry::Instrumentation
  # source://opentelemetry-registry/0.3.0/lib/opentelemetry/instrumentation.rb#21
  def registry; end
end

# Contains the OpenTelemetry instrumentation for the Koala gem
#
# source://opentelemetry-instrumentation-koala//lib/opentelemetry/instrumentation/koala.rb#13
module OpenTelemetry::Instrumentation::Koala; end

# The Instrumentation class contains logic to detect and install the Koala instrumentation
#
# source://opentelemetry-instrumentation-koala//lib/opentelemetry/instrumentation/koala/instrumentation.rb#13
class OpenTelemetry::Instrumentation::Koala::Instrumentation < ::OpenTelemetry::Instrumentation::Base
  private

  # source://opentelemetry-instrumentation-koala//lib/opentelemetry/instrumentation/koala/instrumentation.rb#29
  def patch; end

  # source://opentelemetry-instrumentation-koala//lib/opentelemetry/instrumentation/koala/instrumentation.rb#25
  def require_dependencies; end
end

# source://opentelemetry-instrumentation-koala//lib/opentelemetry/instrumentation/koala/version.rb#10
OpenTelemetry::Instrumentation::Koala::VERSION = T.let(T.unsafe(nil), String)
