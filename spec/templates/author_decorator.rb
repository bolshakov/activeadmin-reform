require 'draper'

class AuthorDecorator < Draper::Decorator
  delegate_all

  def surname
    last_name
  end
end
