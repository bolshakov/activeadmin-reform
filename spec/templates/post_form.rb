class PostForm < Reform::Form
  include ActiveAdmin::Reform::ActiveRecord

  property :text, prepopulator: ->(*) { self.text = 'Initial post text' }

  collection :comments, populate_if_empty: Comment do
    include ActiveAdmin::Reform::ActiveRecord
    model :comment

    property :text, prepopulator: ->(*) { self.text = 'Initial comment text' }
  end
end
