require 'rails_helper'
RSpec.feature 'User Post Index Page', type: :feature do
  before(:each) do

    @user = User.create(name: 'Test User', photo: 'test_photo.jpg')
    @user.save(validate: false)
    @post1 = @user.posts.create(text: 'Post Text 1')
    @post2 = @user.posts.create(text: 'Post Text 2')

    @post1.save(validate: false)
    @post2.save(validate: false)

    @comment1 = @post1.comments.create(text: 'Comment 1', user: @user)
    @comment2 = @post1.comments.create(text: 'Comment 2', user: @user)
    @comment3 = @post2.comments.create(text: 'Comment 3', user: @user)

    @like1 = @post1.likes.create(user: @user)
    @like2 = @post2.likes.create(user: @user)
    visit user_posts_path(@user)
  end

  scenario 'Display user profile information and posts' do
    expect(page).to have_content(@user.name)
    expect(page).to have_css("img[src*='test_photo.jpg']")

    expect(page).to have_content('Post Text 1')
    expect(page).to have_content('Post Text 2')

    expect(page).to have_content(@comment1.text)
    expect(page).to have_content('Comment 2')
    expect(page).to have_content('Comment 3')
    expect(page).to have_content('Likes: 1', count: 2)
    expect(page).to have_button('Like', count: 2, disabled: false)
  end

  scenario 'redirects to post show page on clicking a post' do

    click_link('Post Text 1')
    expect(page).to have_current_path("/users/#{@user.id}/posts/#{@post1.id}")
  end
end
