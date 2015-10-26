require 'reform/form'

class AuthorForm < Reform::Form
  property :last_name, validates: { presence: true }
end
