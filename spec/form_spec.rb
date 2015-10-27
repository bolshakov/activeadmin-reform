require 'spec_helper'

RSpec.describe 'form', type: :feature do
  context 'with form object' do
    before do
      ActiveAdmin.register Author do
        config.filters = false
        permit_params :last_name if Rails::VERSION::MAJOR == 4
        form_class AuthorForm

        form do |f|
          f.semantic_errors(*f.object.errors.keys)
          f.inputs do
            f.input :last_name
          end
          f.actions
        end

        controller do
          def find_collection
            Author.all
          end
        end
      end

      Rails.application.reload_routes!
    end

    describe '#new' do
      it 'uses validation defined in reform' do
        visit '/admin/authors/new'
        expect(page).not_to have_content("Last name can't be blank")
        click_link_or_button 'Create Author'

        expect(page).not_to have_content('Author was successfully created.')
        expect(page).to have_content("Last name can't be blank")

        fill_in 'Last name', with: 'Jane Doe'
        click_link_or_button 'Update Author'

        expect(page).to have_content('Author was successfully updated.')
        expect(page).to have_content('Jane Doe')
      end
    end

    describe '#edit' do
      let!(:author) do
        Author.create!(name: 'Jane')
      end

      it 'uses validation defined in reform' do
        visit "/admin/authors/#{author.id}/edit"
        expect(page).not_to have_content("Last name can't be blank")
        click_link_or_button 'Update Author'

        expect(page).not_to have_content('Author was successfully created.')
        expect(page).to have_content("Last name can't be blank")

        fill_in 'Last name', with: 'Jane Doe'
        click_link_or_button 'Update Author'

        expect(page).to have_content('Author was successfully updated.')
        expect(page).to have_content('Jane Doe')
      end
    end
  end

  context 'without form object' do
    before do
      ActiveAdmin.register Author do
        config.filters = false
        permit_params :last_name if Rails::VERSION::MAJOR == 4
        form_class false

        form do |f|
          f.semantic_errors(*f.object.errors.keys)
          f.inputs do
            f.input :last_name
          end
          f.actions
        end

        controller do
          def find_collection
            Author.all
          end
        end
      end

      Rails.application.reload_routes!
    end

    it 'does not use validation' do
      visit '/admin/authors/new'
      click_link_or_button 'Create Author'

      expect(page).to have_content('Author was successfully created.')
    end
  end

  context 'setter in form object' do
    before do
      ActiveAdmin.register Author do
        config.filters = false
        permit_params :surname if Rails::VERSION::MAJOR == 4
        form_class CommenterForm

        form decorate: true do |f|
          f.semantic_errors(*f.object.errors.keys)
          f.inputs do
            f.input :surname
          end
          f.actions
        end

        controller do
          def find_collection
            Author.all
          end
        end
      end

      Rails.application.reload_routes!
    end

    it 'uses the setter' do
      visit '/admin/authors/new'
      fill_in 'Surname', with: 'Doe'
      click_link_or_button 'Create Commenter'

      expect(page).to have_content('Commenter was successfully created.')
      expect(page).to have_content('Doe')
    end
  end
end
