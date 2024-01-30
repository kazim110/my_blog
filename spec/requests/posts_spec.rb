require 'rails_helper'

RSpec.describe 'posts', type: :request do
  describe 'GET /index' do
    it 'return http success' do
      get '/users/index/posts'

      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get '/users/index/posts/show'

      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Here is a posts for a given user')
    end
  end
end
