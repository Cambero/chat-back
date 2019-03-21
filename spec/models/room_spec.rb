# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to embed_many(:messages) }

  it { is_expected.to belong_to(:user) }

  it 'lastests_messages return 20 lastests messages in reverse order' do
    room = FactoryBot.create(:room)
    room.messages = FactoryBot.build_list(:message, 50)
    expected_rooms = room.messages.reverse.take(20)
    expect(room.lastests_messages).to match_array(expected_rooms)
  end

  it 'after save broadcast the room' do
    room = FactoryBot.build(:room)
    expect { room.save }.to have_broadcasted_to('room_list')
  end
end
