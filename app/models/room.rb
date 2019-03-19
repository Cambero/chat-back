# frozen_string_literal: true

class Room
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :owner, type: String

  validates :name, presence: true
  validates :owner, presence: true
end
