require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  before do
    @user1 = User.create(name: 'User 1', photo: 'url1', bio: 'Bio 1', posts_counter: 3)
    @user2 = User.create(name: 'User 2', photo: 'url2', bio: 'Bio 2', posts_counter: 5)
  end

  scenario 'User can see the username of all other users' do
    visit users_path
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  scenario 'User can see the profile picture and the number of posts each user has written' do
    visit users_path

    # Check for the presence of an image in user entries
    within '.main' do
      expect(page).to have_css('.row img', count: 2)
    end
    # Check for the current number of posts as reflected in the view
    expect(page).to have_content('Number of Posts: 0', count: 2)
  end

  scenario 'User can click the card redirects to user show page' do
    visit users_path
    click_link @user1.name
    expect(current_path).to eq("/users/#{@user1.id}")
  end
end
