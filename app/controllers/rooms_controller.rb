# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :set_room, only: :show

  def index
    @rooms = Room.all
    render json: @rooms, each_serializer: RoomIndexSerializer
  end

  def show
    render json: @room, serializer: RoomShowSerializer
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      render json: @room, status: :created
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :user)
  end
end
