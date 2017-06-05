class WikiController < ApplicationController
  protect_from_forgery
  layout 'wiki'
  skip_before_action :verify_authenticity_token
  skip_before_action :auth_user!

  def index

  end
end
