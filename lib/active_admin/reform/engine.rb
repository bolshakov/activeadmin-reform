require 'rails/engine'

#
module ActiveAdmin
  #
  module Reform
    # Need engine to be absolutely sure active admin is already loaded, and run all it's hooks
    class Engine < Rails::Engine
      initializer 'activeadmin-reform' do
        require 'active_admin'
        require_relative 'dsl'
        require_relative 'forms'
      end
    end
  end
end
