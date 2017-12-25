module ActiveAdmin
  module Reform
    # Decorates `ActiveRecord::Reflection` instances.
    # `ActiveAdmin::FormBuilder#has_many(name)` uses `object.class.reflect_on_association(name).klass.new`
    # to build nested records.
    class Reflection < SimpleDelegator
      # @param reflection [ActiveRecord::Reflection]
      # @param form_class [Class<ActiveAdmin::Reform::ActiveRecord>, nil]
      def initialize(reflection, form_class)
        super(reflection)
        @form_class = form_class
      end

      # @return [Klass]
      def klass
        Klass.new(super, @form_class)
      end

      # Decorates `ActiveRecord::Base` subclasses.
      class Klass < SimpleDelegator
        # @param klass [Class<ActiveRecord::Base>]
        # @param form_class [Class<ActiveAdmin::Reform::ActiveRecord>, nil]
        def initialize(klass, form_class)
          super(klass)
          @form_klass = form_class
        end

        # @return [ActiveAdmin::Reform::ActiveRecord]
        def new(*)
          if @form_klass
            @form_klass.new(super).tap(&:prepopulate!)
          else
            super
          end
        end
      end
    end
  end
end
