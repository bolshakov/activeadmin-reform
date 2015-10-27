require 'active_support/concern'
require_relative 'resource_controller/data_access'

module ActiveAdminReform
  module Forms
    extend ActiveSupport::Concern

    protected

    def apply_form(resource)
      apply_form? ? form_class.new(resource) : resource
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

  ::ActiveAdmin::ResourceController.include(Forms)
end
