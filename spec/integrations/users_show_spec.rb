require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'User Show Page' do
  before(:each) do
    @user = User.create(name: 'Test User', photo: 'user_photo_url', bio: 'Test bio', posts_counter: 3)
    @post1 = @user.posts.create(text: 'Post 1')
    @post2 = @user.posts.create(text: 'Post 2')
    @post3 = @user.posts.create(text: 'Post 3')

    @post1.save(validate: false)
    @post2.save(validate: false)
    @post3.save(validate: false)

    visit user_path(@user)
  end

  scenario 'displays user information to have style' do
    expect(page).to have_css("img[src*='user_photo_url']")
  end

  scenario 'displays user information' do
    expect(page).to have_content('Test User')
    expect(page).to have_content('Number of Posts: 3') 
  end

  scenario 'displays user bio' do
    expect(page).to have_content('Test bio')
  end

  scenario 'displays user\'s first 3 posts' do
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 3')
  end

  scenario 'allows viewing all user posts' do
    click_link('See All Posts')
    expect(page).to have_current_path(user_posts_path(@user))
  end

  scenario 'redirects to post show page on clicking a post' do
    click_link('Post 1')
    expect(page).to have_current_path("/users/#{@user.id}/posts/#{@post1.id}")
  end

  
end
# rubocop:enable Metrics/BlockLength
