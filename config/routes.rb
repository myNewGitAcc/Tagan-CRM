Rails.application.routes.draw do

  resources :exercises

  post      '/wiki_pages', to: 'wiki_pages#create'
  wiki_root '/wiki'

  mount API::Base => '/api'
  mount GrapeSwaggerRails::Engine => '/apidoc'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post 'admin/project_report/get_tracking_time', to: 'admin/project_reports#get_tracking_time'
  get 'admin/users/:id/calendars', to: 'admin/users#user_calendar'

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

  get '/login', to: 'auth#login'

  # namespace :wiki do
  #   resources :articles, only: :index
  # end

  get '/*path' => 'auth#redirect'
end
