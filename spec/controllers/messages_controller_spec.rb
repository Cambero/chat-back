# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe 'POST #create' do
    let(:room) { FactoryBot.create(:room) }

    context 'with valid params' do
      it 'add a new Message' do
        count = room.messages.count
        post :create, params: { room_id: room.id, message: FactoryBot.attributes_for(:message) }
        expect(room.reload.messages.count).to eq(count + 1)
      end

      it 'renders a JSON response with the new message' do
        message = FactoryBot.create(:message, room: room, content: 'a new message')
        post :create, params: { room_id: room.id, message: message.attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.body).to include('a new message')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new message' do
        message_attr = FactoryBot.attributes_for(:message, :invalid)
        post :create, params: { room_id: room.id, message: message_attr }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
