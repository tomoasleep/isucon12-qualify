# typed: true

class Isuports::App
  # Included by helpers
  include Sinatra::Cookies

#   class Viewer
#     sig { returns(String) }
#     attr_accessor :role
#
#     sig { returns(String) }
#     attr_accessor :player_id
#
#     sig { returns(String) }
#     attr_accessor :tenant_name
#
#     sig { returns(Integer) }
#     attr_accessor :tenant_id
#   end
#
#   class TenantRow
#     sig { returns(Integer) }
#     attr_accessor :id
#
#     sig { returns(String) }
#     attr_accessor :name, :display_name
#
#     sig { returns(Integer) }
#     attr_accessor :created_at, :updated_at
#   end
#
#   class TenantRow
#     sig { returns(Integer) }
#     attr_accessor :id
#
#     sig { returns(String) }
#     attr_accessor :name, :display_name
#
#     sig { returns(Integer) }
#     attr_accessor :created_at, :updated_at
#   end
#
#   class PlayerRow
#     sig { returns(Integer) }
#     attr_accessor :tenant_id
#
#     sig { returns(String) }
#     attr_accessor :id, :display_name
#
#     sig { returns(T::Boolean) }
#     attr_accessor :is_disqualified
#
#     sig { returns(Integer) }
#     attr_accessor :created_at, :updated_at
#   end
end
