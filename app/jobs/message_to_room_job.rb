# frozen_string_literal: true

class MessageToRoomJob < ApplicationJob
  queue_as :default

  def perform(options)
    ActionCable.server.broadcast(
      "room_#{options[:room_id]}",
      content: options[:content],
      username: options[:username],
      created_at: options[:created_at]
    )
  end
end
