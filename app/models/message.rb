# frozen_string_literal: true

class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String
  field :content, type: String

  validates :username, presence: true
  validates :content, presence: true

  embedded_in :room
end
