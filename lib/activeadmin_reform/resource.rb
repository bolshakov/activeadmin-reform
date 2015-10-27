require 'active_support/concern'

module ActiveAdminReform
  module Resource
    extend ActiveSupport::Concern
    included do
      attr_accessor :form_class_name
    end

    def form_class
      if form_class_name
        ActiveSupport::Dependencies.constantize(form_class_name)
      end
    end
  end

  ::ActiveAdmin::Resource.include(Resource)
end
