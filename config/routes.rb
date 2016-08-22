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

  post 'inventories/create', to: 'managment/inventories#create'

  delete 'inventories/destroy_inventory', to: 'managment/inventories#destroy_inventory'

  delete 'inventories/destroy_quantity', to: 'managment/inventories#destroy_quantity'

  get 'managment/employees', to: 'managment/employees#index'

  get 'employees/insert_data', to: 'managment/employees#insert_data'

  get 'employees/select', to: 'managment/employees#select'

  post 'employees/create', to: 'managment/employees#create'

  delete 'employees/destroy_employee', to: 'managment/employees#destroy_employee'

  delete 'employees/destroy_quantity', to: 'managment/employees#destroy_quantity'

  get '/*path' => 'auth#redirect'
end