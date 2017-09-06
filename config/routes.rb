Rails.application.routes.draw do

  resources :exercises

  delete  '/wiki/:id',        to: 'wiki_pages#destroy'
  get     '/wiki/new',        to: 'wiki_pages#new'
  post    '/wiki_pages',      to: 'wiki_pages#create'
  get     '/wiki/all',        to: 'wiki_pages#index'
  get     '/wiki/:id',        to: 'wiki_pages#show'
  get     '/wiki/history',    to: 'wiki#history'

  wiki_root '/wiki'
  mount API::Base => '/api'
  mount GrapeSwaggerRails::Engine => '/apidoc'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

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
