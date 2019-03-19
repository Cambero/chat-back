# frozen_string_literal: true

class RoomShowSerializer < ActiveModel::Serializer
  attributes %i[id name owner created_at lastests_messages]

  def id
    object.id.to_s
  end

  def lastests_messages
    object.lastests_messages.map { |msg| MessageSerializer.new(msg) }
  end
end
