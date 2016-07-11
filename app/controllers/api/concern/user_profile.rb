module API
  module Concern::UserProfile
    extend ActiveSupport::Concern
    included do
      segment :users do
        params do
          optional :access_token, type: String, desc: 'security token'
        end
        get '/profile' do
          success! current_user.as_api_response(:my_profile_mode), 200, 'success'
        end
      end
    end
  end
end