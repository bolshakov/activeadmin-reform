class CommenterForm < Reform::Form
  include ActiveAdmin::Reform::ActiveRecord

  model :author

  property :surname, virtual: true, prepopulator: ->(_) { self.surname = model.last_name }

  def sync
    super.tap do
      model.last_name = surname
    end
  end
end
