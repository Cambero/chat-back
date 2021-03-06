# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  describe 'GET #index' do
    it 'respond ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'respond json' do
      get :index
      expect(response.content_type).to eq('application/json')
    end

    it 'assigns rooms to @rooms' do
      rooms = FactoryBot.create_list(:room, 20)
      get :index
      expect(assigns(:rooms)).to match_array(rooms)
    end
  end

  describe 'GET #show' do
    let(:room) { FactoryBot.create(:room) }
    before(:each) { get :show, params: { id: room.id } }

    it 'respond ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'respond json' do
      expect(response.content_type).to eq('application/json')
    end

    it 'assigns room to @room' do
      expect(assigns(:room)).to eq(room)
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    let(:room) { FactoryBot.build(:room, user: user) }

    context 'with valid params' do
      it 'creates a new Room' do
        expect do
          post :create, params: { room: room.attributes }
        end.to change(Room, :count).by(1)
      end

      it 'renders a JSON response with the new room' do
        post :create, params: { room: room.attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['name']).to eq(room.name)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new room' do
        post :create, params: { room: FactoryBot.attributes_for(:room, :invalid) }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
