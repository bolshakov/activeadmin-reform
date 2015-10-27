require 'active_support/concern'
require_relative 'resource'

module ActiveAdminReform
  extend ActiveSupport::Concern

  module Dsl
    def form_class(form_class)
      config.form_class_name = form_class ? "::#{form_class}" : nil
    end
  end

  ::ActiveAdmin::ResourceDSL.include(Dsl)
end
