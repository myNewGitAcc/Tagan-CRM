Rails.application.routes.draw do
  mount API::Base => '/'
  mount GrapeSwaggerRails::Engine => '/apidoc'

  root 'welcome#index'

  def shared_devise_path
    {
        sign_in:  'login',
        sign_out: 'logout'
    }
  end

  devise_for :users,
             path: 'access',
             path_names: shared_devise_path,
             skip: [:registrations],
             controllers: {
                 passwords: 'access/passwords',
                 confirmations: 'access/confirmations',
                 sessions: "access/sessions"
             }

end
