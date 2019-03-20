# frozen_string_literal: true

class RoomIndexSerializer < ActiveModel::Serializer
  attributes %i[id name user created_at]

  def id
    object.id.to_s
  end

  def user
    object.user.username
  end
end
