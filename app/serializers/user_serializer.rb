# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :username

  def id
    object.id.to_s
  end
end
