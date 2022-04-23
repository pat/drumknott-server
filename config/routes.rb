# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV.fetch("SIDEKIQ_USERNAME") &&
      password == ENV.fetch("SIDEKIQ_PASSWORD")
  end if Rails.env.production?
  mount Sidekiq::Web, :at => "/sidekiq"

  devise_for :users, :controllers => {:registrations => "registrations"}

  root "welcome#index"
  get "/documentation" => "welcome#documentation"
  get "/privacy"       => "welcome#privacy"
  get "/terms"         => "welcome#terms"

  mount V1.new => "/api/v1"

  mount StripeEvent::Engine, :at => "/hooks/stripe"

  namespace :my do
    get "/dashboard" => "dashboard#index", :as => :dashboard

    resource :account, :only => %i[ edit update destroy ] do
      member { put :change_card }
    end
    resources :sites do
      member { post :regenerate }
    end
    resources :invoices, :only => %i[ index show ]
  end
end
