require 'reform'

class CommenterForm < Reform::Form
  property :surname, virtual: true, prepopulator: ->(_) { self.surname = model.last_name }

  def sync
    super.tap do
      model.last_name = surname
    end
  end
end
