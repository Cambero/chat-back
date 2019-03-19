# frozen_string_literal: true

class RoomSerializer < ActiveModel::Serializer
  attributes %i[id name owner created_at]

  def id
    object.id.to_s
  end
end
