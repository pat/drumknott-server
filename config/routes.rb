Rails.application.routes.draw do
  # root 'welcome#index'

  mount V1.new => '/api/v1'
end
