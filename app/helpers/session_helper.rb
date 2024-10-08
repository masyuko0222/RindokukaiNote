# frozen_string_literal: true

module SessionHelper
  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def logged_in?
    current_user.present?
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil # rubocop:disable Rails/HelperInstanceVariable
  end
end
