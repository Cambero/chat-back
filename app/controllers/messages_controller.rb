# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @room.messages << Message.new(message_params)
    if @room.save
      render json: @room.messages.last, status: :created
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:username, :content)
  end
end
