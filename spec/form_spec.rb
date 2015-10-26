require 'spec_helper'

RSpec.describe 'form', type: :feature do
  before do
    ActiveAdmin.register Author do
      # form_class AuthorForm

      form do |f|
        f.input :last_name
      end
    end

    system 'rake routes'
  end

  it '' do
    visit '/admin/authors'
    save_and_open_page
  end
end
