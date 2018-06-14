require 'reform'
require 'reform/form/active_record'
require 'reform/form/active_model/model_reflections'

module ActiveAdmin
  module Reform
    # Module that prepares the Reform::Form for use in activeadmin
    module ActiveRecord
      extend ActiveSupport::Concern

      delegate :new_record?, to: :model

      # @return [Boolean]
      # Used here - https://github.com/activeadmin/activeadmin/blob/487f976/lib/active_admin/resource_controller/data_access.rb#L160
      def save
        validate({}) && (super || validate({}))
      end

      # @param attributes [Hash]
      # Used here - https://github.com/activeadmin/activeadmin/blob/487f976/lib/active_admin/resource_controller/data_access.rb#L301
      def assign_attributes(attributes)
        deserialize(attributes)
      end

      included do
        include ::Reform::Form::ModelReflections
        include ::Reform::Form::ActiveRecord

        validate { model.errors.each { |key, error| errors.add key, error } }

        class << self
          def reflect_on_association(name)
            reflection = model_class.reflect_on_association(name) || return
            property = definitions[name.to_s]
            @reflections ||= {}
            @reflections[name] ||= Reflection.new(reflection, (property[:nested] if property))
          end
        end
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
