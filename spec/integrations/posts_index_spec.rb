require 'rails_helper'
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

  scenario 'Display user profile information and posts' do
    # Check if user profile information is displayed
    expect(page).to have_content(@user.name)
    expect(page).to have_css("img[src*='test_photo.jpg']") # Assuming user photo is displayed via an img tag

    # Check if posts and associated comments/likes are displayed
    expect(page).to have_content('Post Text 1')
    expect(page).to have_content('Post Text 2')

    expect(page).to have_content(@comment1.text)
    expect(page).to have_content('Comment 2')
    expect(page).to have_content('Comment 3')
    expect(page).to have_content('Likes: 1', count: 2) # Assuming each post has one like
    expect(page).to have_button('Like', count: 2, disabled: false) # Assuming there are buttons for liking posts
  end

  scenario 'redirects to post show page on clicking a post' do
    # Click on a post and check if it redirects to the post's show page
    click_link('Post Text 1') # Replace with the specific text/title of the post you want to click
    expect(page).to have_current_path("/users/#{@user.id}/posts/#{@post1.id}")
  end
end
