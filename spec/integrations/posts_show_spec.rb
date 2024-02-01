require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'Post details display', type: :feature do
  before(:each) do
    # Create a user for post author
    @user = User.create(name: 'User 1', photo: 'url1', bio: 'Bio 1', posts_counter: 1)
    @user.save(validate: false)
    # Create a post associated with the user
    @post = @user.posts.create(text: 'This is the content of the post')
    @post.save(validate: false)
    # Create comments associated with the post
    @comment1 = @post.comments.create(user: @user, text: 'Comment 1 text')
    @comment2 = @post.comments.create(user: @user, text: 'Comment 2 text')
    @comment1.save(validate: false)
    @comment2.save(validate: false)
    # Create likes for posts
    @like1 = @post.likes.create(user: @user)
    @like2 = @post.likes.create(user: @user)

    visit user_post_path(user_id: @user.id, id: @post.id)
  end
  scenario 'Display post details and comments' do
    # Check if post details are displayed
    expect(page).to have_content(@post.title)
    expect(page).to have_content(@user.name)
    expect(page).to have_content('Comments: 2') # Assuming 2 comments were created in the before block
    expect(page).to have_content('This is the content of the post')
    # Check if comments are displayed
    expect(page).to have_content('Comment 1 text')
    expect(page).to have_content('Comment 2 text')
    # Check if 'New Comment' link is present
    expect(page).to have_link('New Comment', href: new_user_post_comment_path(@user, @post))
  end

  scenario 'displays the number of likes for the post' do
    expect(page).to have_content('Likes: 2') # Assuming there are no likes initially
  end

  scenario 'displays usernames of commenters' do
    # Check if usernames of commenters are displayed
    expect(page).to have_content('User 1')
  end

  scenario 'displays comments left by each commenter' do
    # Check if comments left by each commenter are displayed
    expect(page).to have_content('Comment 1 text')
    expect(page).to have_content('Comment 2 text')
  end
end
# rubocop:enable Metrics/BlockLength
