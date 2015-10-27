require 'reform'

class CommenterForm < Reform::Form
  property :surname, virtual: true

  def surname=(value)
    model.last_name = value
  end

  def surname
    model.last_name
  end
end
