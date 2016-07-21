require 'reform/form/active_model/model_reflections'

module ActiveAdmin
  module Reform
    # Patching ActiveAdmin::FormBuilder#js_for_has_many to provide nested forms support
    # https://github.com/activeadmin/activeadmin/blob/539fa4b/lib/active_admin/form_builder.rb#L123
    module FormBuilder
      private

      # Capture the ADD JS
      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      def js_for_has_many(assoc, form_block, template, new_record, class_string)
        assoc_reflection = object.class.reflect_on_association assoc
        assoc_name       = assoc_reflection.klass.model_name
        placeholder      = "NEW_#{assoc_name.to_s.underscore.upcase.gsub(%r{/}, '_')}_RECORD"
        opts = {
          for: [assoc, nested_object(assoc)],
          class: class_string,
          for_options: { child_index: placeholder },
        }
        html = template.capture { inputs_for_nested_attributes opts, &form_block }
        text = new_record.is_a?(String) ? new_record : I18n.t('active_admin.has_many_new', model: assoc_name.human)

        template.link_to text, '#', class: 'button has_many_add', data: {
          html: CGI.escapeHTML(html).html_safe, placeholder: placeholder
        }
      end
      # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

      def nested_form_class(assoc)
        if object.is_a?(::Reform::Form) && (property = object.class.definitions[assoc.to_s]) &&
           (nested_form = property[:nested]) < ::Reform::Form
          nested_form
        end
      end

      def nested_object(assoc)
        assoc_reflection = object.class.reflect_on_association assoc
        if (nested_form = nested_form_class(assoc))
          nested_form.new(assoc_reflection.klass.new).tap(&:prepopulate!)
        else
          assoc_reflection.klass.new
        end
      end
    end
  end
end
