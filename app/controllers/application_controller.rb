# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  before_action :set_csrf_cookie

  protect_from_forgery with: :exception

  rescue_from Mongoid::Errors::DocumentNotFound do |_e|
    render json: { error: 'Not Found' }, status: :not_found
  end

  rescue_from ActionController::InvalidAuthenticityToken do |_e|
    render json: { error: 'Invalid token' }, status: :unauthorized
  end

  private

  def set_csrf_cookie
    cookies['CSRF-TOKEN'] = form_authenticity_token
  end

  def authenticate_user
    unless current_user
      render json: { error: 'Requires authentication' },
             status: :unauthorized
      return
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
