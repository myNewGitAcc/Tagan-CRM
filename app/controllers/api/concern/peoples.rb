module API
  module Concern::Peoples
    extend ActiveSupport::Concern
    included do
      desc "Return Users data."

      get '/users' do
        users = User.all
        success!(users.as_api_response(:basic), status)
      end

      # desc "Return logout status."
      # params do
      #   optional :access_token, type: String, desc: 'Security token'
      # end
      # delete '/logout' do
      #   authenticate_user!
      #   logout_user!
      #   {code: 200, status:"success", message: "You are logged out successfully"}
      # end
    end
  end
end
