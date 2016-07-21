class AuthorForm < Reform::Form
  include ActiveAdmin::Reform::ActiveRecord

  property :last_name, validates: { presence: true }
end
