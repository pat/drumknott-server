Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'

  mount V1.new => '/api/v1'

  mount StripeEvent::Engine, at: '/hooks/stripe'

  namespace :my do
    resources :sites
  end
end
