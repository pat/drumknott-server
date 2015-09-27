Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'

  mount V1.new => '/api/v1'
end
