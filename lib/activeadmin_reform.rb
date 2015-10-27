# require 'active_support'
require 'rails/engine'

module ActiveAdminReform
  # Need engine to be absolutely sure active admin is already loaded, and run all it's hooks
  class Railtie < Rails::Engine
    initializer 'active_admin_reform' do
      require 'active_admin'
      require_relative 'activeadmin_reform/dsl'
      require_relative 'activeadmin_reform/forms'
    end
  end
end
