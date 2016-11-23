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
        if apply_form?(resource)
          form = form_class.new(resource)
          form.prepopulate! if prepopulate_form?
          form
        else
          resource
        end
      end

      private

      def prepopulate_form?
        %w(new edit).include?(action_name)
      end

      def apply_form?(resource)
        case action_name
        when 'new', 'edit', 'update', 'create'
          form_class.present? && !resource.is_a?(::Reform::Form)
        end
      end

      def form_class
        active_admin_config.form_class
      end
    end

    ::ActiveAdmin::ResourceController.send(:include, Forms)
  end
end
