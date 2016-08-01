Rails.application.routes.draw do



  mount API::Base => '/api'
  mount GrapeSwaggerRails::Engine => '/apidoc'

  # namespace :admin do
  #   resources :admin_user # Have the admin manage them here.
  # end
  root to: 'application#show'

  def shared_devise_path
    {
        sign_in:  'login',
        sign_out: 'logout'
    }
  end

  devise_for :users,
             path: 'access',
             path_names: shared_devise_path,
             controllers: {
                 passwords: 'access/passwords',
                 confirmations: 'access/confirmations',
                 sessions: 'access/sessions',
             }

  ActiveAdmin.routes(self)

  get '/login', to: 'auth#login'
  namespace :managment do
    resources :inventories
  end

  get '/*path' => 'auth#redirect'

end
