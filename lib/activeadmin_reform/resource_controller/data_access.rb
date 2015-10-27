require 'reform'
require 'active_support/concern'

module ActiveAdminReform
  module ResourceController
    module DataAccess
      extend ActiveSupport::Concern

      def apply_decorations(resource)
        resource = super(resource)
        apply_form(resource)
      end

      def assign_attributes(resource, attributes)
        if resource.is_a?(Reform::Form)
          resource.validate(*attributes)
          resource
        else
          super(resource, attributes)
        end
      end
    end

    ::ActiveAdmin::ResourceController.include(DataAccess)
  end
end
