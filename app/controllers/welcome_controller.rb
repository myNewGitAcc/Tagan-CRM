class WelcomeController < ApplicationController
  skip_before_action :auth_user!

  def index
  end
end
