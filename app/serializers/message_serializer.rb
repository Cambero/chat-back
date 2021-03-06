# frozen_string_literal: true

class MessageSerializer < ActiveModel::Serializer
  attributes :id, :username, :content, :created_at

  def id
    object.id.to_s
  end
end
