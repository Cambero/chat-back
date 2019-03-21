# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Rooms', type: :request do
  describe 'GET #index' do
    it 'return all rooms' do
      rooms = FactoryBot.create_list(:room, 20)
      get rooms_path
      expect(JSON.parse(response.body).size).to eq(rooms.count)
    end
  end

  describe 'GET #show' do
    it 'return the room' do
      room = FactoryBot.create(:room)
      get rooms_path, params: { id: room.id }
      expect(JSON.parse(response.body).first.fetch('id')).to eq(room.id.to_s)
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    let(:room) { FactoryBot.build(:room, user: user) }
    it 'creates a new room' do
      expect do
        post rooms_path, params: { room: room.attributes }
      end.to change(Room, :count).by(1)
    end

    it 'return created room asociated to user' do
      post rooms_path, params: { room: room.attributes }
      expect(JSON.parse(response.body).fetch('user')).to eq(user.username)
    end
  end
end
