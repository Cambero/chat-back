# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  describe 'POST #create' do
    let(:room) { FactoryBot.create(:room) }
    it 'return created message' do
      post room_messages_path(
        room_id: room.id,
        message: FactoryBot.attributes_for(:message, content: 'api msg')
      )
      expect(JSON.parse(response.body).fetch('content')).to eq('api msg')
    end
  end
end
