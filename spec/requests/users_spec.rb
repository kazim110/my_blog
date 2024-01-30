require 'rails_helper'

RSpec.describe 'users', type: :request do
  describe 'GET /index' do
    it 'return http success' do
      get '/users'
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Here is a list of user')
    end
  end

  describe "GET /users/:id" do
    it "renders the show template" do
      user = User.create(name: 'John Doe', photo: 'home/document/pic.jpeg', bio: 'teacher', posts_counter: 3) # Adjust attributes as needed

      get user_path(user)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end
end
