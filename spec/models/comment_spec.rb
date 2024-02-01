require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Alice') }
  let(:post) { Post.create(title: 'Sample Post', author: user) }
  let(:comment) { Comment.new(text: 'Great post!', post:, user:) }

  it 'is valid with valid attributes' do
    expect(comment).to be_valid
  end
end
