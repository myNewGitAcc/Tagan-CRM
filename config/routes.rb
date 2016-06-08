Rails.application.routes.draw do
  mount API::Base => '/api'
  mount GrapeSwaggerRails::Engine => '/apidoc'

  # root 'welcome#index'
  root to: 'application#show'

  def shared_devise_path
    {
        sign_up:  'register',
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
                 registrations: 'access/registrations'
             }

  get '/login', to: 'auth#login'
  get '/registration', to: 'auth#registration'


  # # match '*path' => redirect('/'), via: :get
  # get '/*path' => redirect('/'), via: :get
end
