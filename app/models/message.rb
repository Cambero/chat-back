# frozen_string_literal: true

class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String
  field :content, type: String

  validates :username, presence: true
  validates :content, presence: true

  embedded_in :room

  set_callback(:save, :after) do |message|
    ActionCable.server.broadcast(
      "room_#{room.id}",
      content: message.content,
      username: message.username,
      created_at: message.created_at
    )
  end
end
