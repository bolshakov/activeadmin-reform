require 'reform'
require 'active_support/concern'

module ActiveAdminReform
  #
  module ResourceController
    # Overrides ActiveAdmin' templates method to wrap model into Reform::Form
    module DataAccess
      extend ActiveSupport::Concern

      # @param resource [ActiveRecord::Base]
      # @return [ActiveRecord::Base, Reform::Form]
      def apply_decorations(resource)
        resource = super(resource)
        apply_form(resource)
      end

      # @param resource [ActiveRecord::Base, Reform::Form]
      # @param attributes [(Hash)]
      # @return [ActiveRecord::Base, Reform::Form]
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
