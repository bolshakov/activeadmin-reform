require 'active_support/concern'

#
module ActiveAdmin
  #
  module Reform
    # Defines form class accessor
    module Resource
      extend ActiveSupport::Concern

      included do
        attr_accessor :form_class_name
      end

      # @return [nil, Class<Reform::Form>]
      def form_class
        ActiveSupport::Dependencies.constantize(form_class_name) if form_class_name
      end
    end

    ::ActiveAdmin::Resource.send(:include, Resource)
  end
end
