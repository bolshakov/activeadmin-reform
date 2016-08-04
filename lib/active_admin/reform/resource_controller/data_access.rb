require 'reform'
require 'active_support/concern'

#
module ActiveAdmin
  #
  module Reform
    #
    module ResourceController
      # Overrides ActiveAdmin' templates method to wrap model into Reform::Form
      module DataAccess
        extend ActiveSupport::Concern

        # @param _resource [ActiveRecord::Base]
        # @return [ActiveRecord::Base, Reform::Form]
        def apply_decorations(_resource)
          apply_form(super)
        end
      end

      ::ActiveAdmin::ResourceController.send(:include, DataAccess)
    end
  end
end
