# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'POST #create' do
    let!(:user) { FactoryBot.create(:user) }
    let(:session_params) { { session: { username: user.username, password: 'secret' } } }

    it 'Signin with valid auth return json with user' do
      post session_path, params: session_params
      expect(JSON.parse(response.body).fetch('username')).to eq(user.username)
    end

    it 'Signin with invalid return unauthorized' do
      session_params[:session][:password] = 'wrong'
      puts session_params
      post session_path, params: session_params
      expect(response).to have_http_status(:unauthorized)
      puts JSON.parse(response.body)
      expect(JSON.parse(response.body)['error']).to eq('Invalid credentials')
    end
  end

  describe 'delete #destroy' do
    it 'for now only should return ok' do
      delete session_path
      expect(response).to have_http_status(:ok)
    end
  end
end
