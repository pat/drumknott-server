require 'sidekiq/web'

Rails.application.routes.draw do
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['SIDEKIQ_USERNAME'] && password == ENV['SIDEKIQ_PASSWORD']
  end if Rails.env.production?
  mount Sidekiq::Web, at: '/sidekiq'

  devise_for :users

  root 'welcome#index'

  mount V1.new => '/api/v1'

  mount StripeEvent::Engine, :at => '/hooks/stripe'

  namespace :my do
    get '/dashboard' => 'dashboard#index', :as => :dashboard

    resource :account
    resources :sites do
      member { post :regenerate }
    end
  end
end
