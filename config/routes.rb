Rails.application.routes.draw do
  mount API::Base => '/api'
  mount GrapeSwaggerRails::Engine => '/apidoc'

  #devise_for :admin_users, ActiveAdmin::Devise.config

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

  get 'managment/inventories', to: 'managment/inventories#index'

  post 'managment/inventories', to: 'managment/inventories#create'

  get 'managment/employees', to: 'managment/employees#index'

  get 'managment/insert_data', to: 'managment/employees#insert_data'

  post 'managment/employees', to: 'managment/employees#create'

  get '/*path' => 'auth#redirect'
end