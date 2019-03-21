# frozen_string_literal: true

class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String
  field :content, type: String

  validates :username, presence: true
  validates :content, presence: true

  embedded_in :room

  set_callback(:create, :after) do |message|
    MessageToRoomJob.perform_later(
      room_id: room.id.to_s,
      content: message.content,
      username: message.username,
      created_at: message.created_at.to_s(:db)
    )

    MessageToMentionedsJob.perform_later(
      content: message.content,
      username: message.username,
      roomname: message.room.name
    )
  end
end
