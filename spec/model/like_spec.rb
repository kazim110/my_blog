require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Bob') }
  let(:post) { Post.create(title: 'Another Post', author: user) }
  let(:like) { Like.new(user:, post:) }

  it 'is valid with valid attributes' do
    expect(like).to be_valid
  end
end
