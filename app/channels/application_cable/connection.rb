# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      return if request.params['user_id'].blank?

      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user
    end

    private

    def find_verified_user
      if (verified_user = User.find(request.params['user_id']))
        verified_user.id
      else
        reject_unauthorized_connection
      end
    end
  end
end
