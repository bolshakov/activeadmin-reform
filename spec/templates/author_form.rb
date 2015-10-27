require 'reform'

class AuthorForm < Reform::Form
  property :last_name, :validates => { presence: true }
  property :name
end
