require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'User Post Index Page', type: :feature do
  before(:each) do
    # Create a user and associated posts with comments and likes for testing
    @user = User.create(name: 'Test User', photo: 'test_photo.jpg')
    @user.save(validate: false)
    @post1 = @user.posts.create(text: 'Post Text 1')
    @post2 = @user.posts.create(text: 'Post Text 2')

    @post1.save(validate: false)
    @post2.save(validate: false)

    # Create comments for posts
    @comment1 = @post1.comments.create(text: 'Comment 1', user: @user)
    @comment2 = @post1.comments.create(text: 'Comment 2', user: @user)
    @comment3 = @post2.comments.create(text: 'Comment 3', user: @user)

    # Create likes for posts
    @like1 = @post1.likes.create(user: @user)
    @like2 = @post2.likes.create(user: @user)
    visit user_posts_path(@user)
  end

  it 'displays paginated posts' do
    expect(page).to have_selector('.pagination', count: 1)
  end

  scenario 'Disply user name' do
    expect(page).to have_content(@user.name)
  end

  scenario 'Display user photo' do
    expect(page).to have_css("img[src*='test_photo.jpg']")
  end

  scenario 'Display user posts text' do
    expect(page).to have_content('Post Text 1')
    expect(page).to have_content('Post Text 2')
  end

  scenario 'Display user posts count' do
    expect(page).to have_content('Number of Posts: 2')
  end

  scenario 'Display user comments count' do
    expect(page).to have_content('Comments: 2', count: 1)
  end

  scenario 'Display user likes count' do
    expect(page).to have_content('Likes: 1', count: 2)
  end

  scenario 'Display user posts comments' do
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content('Comment 2')
    expect(page).to have_content('Comment 3')
  end

  scenario 'Display user posts likes' do
    expect(page).to have_content('Likes: 1', count: 2)
    expect(page).to have_button('Like', count: 2, disabled: false)
  end

  scenario 'redirects to post show page on clicking a post' do
    click_link('Post Text 1')
    expect(page).to have_current_path("/users/#{@user.id}/posts/#{@post1.id}")
  end
end
# rubocop:enable Metrics/BlockLength
