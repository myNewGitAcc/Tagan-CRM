class Access::SessionsController < Devise::SessionsController
  skip_before_action :auth_user!
  respond_to :json




  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?

    respond_to do |format|
      format.json {render json: (current_user.as_api_response(:default_token)).as_json.merge(csrfParam: request_forgery_protection_token, csrfToken: form_authenticity_token) }
    end
  end

end
