# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:owner) }

  it { is_expected.to embed_many(:messages) }

  it 'lastests_messages return 20 lastests messages in reverse order' do
    room = FactoryBot.create(:room)
    room.messages = FactoryBot.build_list(:message, 50)
    expected_rooms = room.messages.reverse.take(20)
    expect(room.lastests_messages).to match_array(expected_rooms)
  end
end
