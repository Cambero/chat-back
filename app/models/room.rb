# frozen_string_literal: true

class Room
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :user

  validates :name, presence: true
  validates :user, presence: true

  embeds_many :messages, cascade_callbacks: true

  set_callback(:create, :after) do |room|
    ActionCable.server.broadcast(
      'room_list',
      id:   room.id.to_s,
      name: room.name,
      user: room.user.username
    )
  end

  def lastests_messages
    messages.order_by(created_at: :desc).limit(20).reverse
  end
end
