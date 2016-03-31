require 'active_support/concern'
require_relative 'resource_controller/data_access'

#
module ActiveAdmin
  #
  module Reform
    # Reform integration helpers
    module Forms
      extend ActiveSupport::Concern

      protected

      # Wrap resource into Reform::Form if needed
      # @param resource [ActiveRecord::Base]
      # @return [ActiveRecord::Base, Reform::Form]
      def apply_form(resource)
        if apply_form?
          form_class.new(resource).tap do |form|
            form.prepopulate! if %w(new edit).include?(action_name)
          end
        else
          resource
        end
      end

      private

      def apply_form?
        case action_name
        when 'new', 'edit', 'update', 'create'
          form_class.present?
        end
      end

      def form_class
        active_admin_config.form_class
      end
    end

    ::ActiveAdmin::ResourceController.send(:include, Forms)
  end
end
