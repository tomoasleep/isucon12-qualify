# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `opentelemetry-instrumentation-delayed_job` gem.
# Please instead update this file by running `bin/tapioca gem opentelemetry-instrumentation-delayed_job`.

# OpenTelemetry is an open source observability framework, providing a
# general-purpose API, SDK, and related tools required for the instrumentation
# of cloud-native software, frameworks, and libraries.
#
# The OpenTelemetry module provides global accessors for telemetry objects.
# See the documentation for the `opentelemetry-api` gem for details.
#
# source://opentelemetry-instrumentation-delayed_job//lib/opentelemetry/instrumentation.rb#13
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

# "Instrumentation" are specified by
# https://github.com/open-telemetry/opentelemetry-specification/blob/784635d01d8690c8f5fcd1f55bdbc8a13cf2f4f2/specification/glossary.md#instrumentation-library
#
# Instrumentation should be able to handle the case when the library is not installed on a user's system.
#
# source://opentelemetry-instrumentation-delayed_job//lib/opentelemetry/instrumentation.rb#18
module OpenTelemetry::Instrumentation
  # source://opentelemetry-registry/0.3.0/lib/opentelemetry/instrumentation.rb#21
  def registry; end
end

# Contains the OpenTelemetry instrumentation for the DelayedJob gem
#
# source://opentelemetry-instrumentation-delayed_job//lib/opentelemetry/instrumentation/delayed_job.rb#13
module OpenTelemetry::Instrumentation::DelayedJob; end

# Instrumentation class that detects and installs the DelayedJob instrumentation
#
# source://opentelemetry-instrumentation-delayed_job//lib/opentelemetry/instrumentation/delayed_job/instrumentation.rb#11
class OpenTelemetry::Instrumentation::DelayedJob::Instrumentation < ::OpenTelemetry::Instrumentation::Base
  private

  # source://opentelemetry-instrumentation-delayed_job//lib/opentelemetry/instrumentation/delayed_job/instrumentation.rb#36
  def register_tracer_plugin; end

  # source://opentelemetry-instrumentation-delayed_job//lib/opentelemetry/instrumentation/delayed_job/instrumentation.rb#32
  def require_dependencies; end
end

# source://opentelemetry-instrumentation-delayed_job//lib/opentelemetry/instrumentation/delayed_job/instrumentation.rb#12
OpenTelemetry::Instrumentation::DelayedJob::Instrumentation::MINIMUM_VERSION = T.let(T.unsafe(nil), Gem::Version)

# source://opentelemetry-instrumentation-delayed_job//lib/opentelemetry/instrumentation/delayed_job/version.rb#10
OpenTelemetry::Instrumentation::DelayedJob::VERSION = T.let(T.unsafe(nil), String)
