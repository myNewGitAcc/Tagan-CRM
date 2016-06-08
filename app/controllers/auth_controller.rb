class AuthController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token
  skip_before_action :auth_user!
  # before_action :auth_user_additional!

  def login
  end

  def registration
  end

  def forgot_password
  end
end
