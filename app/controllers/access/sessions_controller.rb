class Access::SessionsController < Devise::SessionsController
  skip_before_action :auth_user!

  prepend_before_filter :allow_params_authentication!, only: :create
  prepend_before_filter only: [ :create, :destroy ] { request.env["devise.skip_timeout"] = true }
end