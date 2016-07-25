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

        # @param resource [ActiveRecord::Base, Reform::Form]
        # @param attributes [(Hash)]
        # @return [ActiveRecord::Base, Reform::Form]
        def assign_attributes(resource, attributes)
          if resource.is_a?(::Reform::Form)
            resource.validate(*attributes) unless %w(new edit).include?(action_name)
            resource
          else
            super
          end
        end

        # Calls all the appropriate callbacks and then saves the new resource.
        #
        # @param [ActiveRecord::Base] object The new resource to save
        #
        # @return [void]
        def save_resource(object)
          if resource.is_a?(::Reform::Form)
            super unless object.errors.any?
          else
            super
          end
        end
      end

      ::ActiveAdmin::ResourceController.send(:include, DataAccess)
    end
  end
end
