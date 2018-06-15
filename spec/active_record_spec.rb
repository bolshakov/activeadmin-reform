RSpec.describe ActiveAdmin::Reform::ActiveRecord do
  describe '#save' do
    subject(:save) do
      form.assign_attributes(attributes)
      form.save
    end
    let(:form) { PostForm.new(post) }
    let(:post) { Post.new }

    context 'model validation fails' do
      let(:attributes) { { text: '' } }

      it do
        expect { save }.not_to change(Post, :count)
        expect(save).to be_falsey
        expect(form.errors).not_to be_empty
        expect(form.errors[:text]).to contain_exactly("can't be blank")
      end
    end

    context 'model validation succeeds' do
      let(:attributes) { { text: 'text' } }

      it do
        expect { save }.to change(Post, :count)
        expect(save).to be_truthy
        expect(form.errors).to be_empty
      end
    end
  end
end
