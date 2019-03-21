# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST #create' do
    it 'Signup create a new user' do
      expect do
        post users_path, params: { user: FactoryBot.attributes_for(:user, password: 'secret') }
      end.to change(User, :count).by(1)
    end

    it 'return json for created user' do
      user_attrs = FactoryBot.attributes_for(:user, username: 'pegaso', password: 'secret')
      post users_path, params: { user: user_attrs }
      expect(JSON.parse(response.body).fetch('username')).to eq('pegaso')
    end

    it 'fails if username already exits' do
      user = FactoryBot.create(:user)
      post users_path, params: { user: user.attributes, password: 'secret' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']['username']).to eq(['is already taken'])
    end
  end
end
