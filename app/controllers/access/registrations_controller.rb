class Access::RegistrationsController < Devise::RegistrationsController
  skip_before_action :auth_user!
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)

        respond_to do |format|
          format.json {render json: (current_user.as_api_response(:default_token)).as_json.merge(csrfParam: request_forgery_protection_token, csrfToken: form_authenticity_token) }
        end
      else
        super
      end
    else
      super
    end
  end

end