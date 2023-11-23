# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `opentelemetry-instrumentation-active_record` gem.
# Please instead update this file by running `bin/tapioca gem opentelemetry-instrumentation-active_record`.

# OpenTelemetry is an open source observability framework, providing a
# general-purpose API, SDK, and related tools required for the instrumentation
# of cloud-native software, frameworks, and libraries.
#
# The OpenTelemetry module provides global accessors for telemetry objects.
# See the documentation for the `opentelemetry-api` gem for details.
#
# source://opentelemetry-instrumentation-active_record//lib/opentelemetry/instrumentation.rb#13
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
# source://opentelemetry-instrumentation-active_record//lib/opentelemetry/instrumentation.rb#15
module OpenTelemetry::Instrumentation
  # source://opentelemetry-registry/0.3.0/lib/opentelemetry/instrumentation.rb#21
  def registry; end
end

# Contains the OpenTelemetry instrumentation for the ActiveRecord gem
#
# source://opentelemetry-instrumentation-active_record//lib/opentelemetry/instrumentation/active_record.rb#13
module OpenTelemetry::Instrumentation::ActiveRecord; end

# The Instrumentation class contains logic to detect and install the ActiveRecord instrumentation
#
# source://opentelemetry-instrumentation-active_record//lib/opentelemetry/instrumentation/active_record/instrumentation.rb#11
class OpenTelemetry::Instrumentation::ActiveRecord::Instrumentation < ::OpenTelemetry::Instrumentation::Base
  private

  # source://opentelemetry-instrumentation-active_record//lib/opentelemetry/instrumentation/active_record/instrumentation.rb#29
  def gem_version; end

  # source://opentelemetry-instrumentation-active_record//lib/opentelemetry/instrumentation/active_record/instrumentation.rb#33
  def patch; end

  # source://opentelemetry-instrumentation-active_record//lib/opentelemetry/instrumentation/active_record/instrumentation.rb#53
  def require_dependencies; end
end

# source://opentelemetry-instrumentation-active_record//lib/opentelemetry/instrumentation/active_record/instrumentation.rb#12
OpenTelemetry::Instrumentation::ActiveRecord::Instrumentation::MINIMUM_VERSION = T.let(T.unsafe(nil), Gem::Version)

# source://opentelemetry-instrumentation-active_record//lib/opentelemetry/instrumentation/active_record/version.rb#10
OpenTelemetry::Instrumentation::ActiveRecord::VERSION = T.let(T.unsafe(nil), String)
