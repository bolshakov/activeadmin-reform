require 'reform'
require 'reform/form/active_record'
require 'reform/form/active_model/model_reflections'

module ActiveAdmin
  module Reform
    # Module that prepares the Reform::Form for use in activeadmin
    module ActiveRecord
      extend ActiveSupport::Concern

      delegate :new_record?, to: :model

      def save_model
        super.tap do
          errors.merge!(model.errors, [])
        end
      end

      included do
        include ::Reform::Form::ModelReflections
        include ::Reform::Form::ActiveRecord
      end

      # Those methods are being used by activeadmin and are proxied to an inferred from name model
      module ClassMethods
        delegate :human_attribute_name, to: :model_class
        delegate :lookup_ancestors, to: :model_class

        def model_class
          @model_class ||= model_name.to_s.constantize
        end
      end
    end
  end
end
