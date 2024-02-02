require 'rails_helper'

RSpec.feature 'User creates a post', type: :feature do
  before(:each) do
    # Create a user for testing
    @user = User.create(name: 'User 1', photo: 'url1', bio: 'Bio 1', posts_counter: 1)
  end

  scenario 'User creates a new post' do
    visit new_user_post_path(@user)

    # Fill in the form fields with data
    fill_in 'Title', with: 'New Post Title'
    fill_in 'Text', with: 'This is the content of the new post'

    # Submit the form
    click_button 'Create Post'
    # Assuming successful post creation redirects to a different path, check the redirection
    expect(page).to have_current_path(user_posts_path(@user))
    # Check if the newly created post content is displayed on the page
    expect(page).to have_content('This is the content of the new post')
  end
end
