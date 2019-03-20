# frozen_string_literal: true

class RoomShowSerializer < ActiveModel::Serializer
  attributes %i[id name user created_at lastests_messages]

  def id
    object.id.to_s
  end

  def user
    object.user.username
  end

  def lastests_messages
    object.lastests_messages.map { |msg| MessageSerializer.new(msg) }
  end
end
