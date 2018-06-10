Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  # namespace :api do
  #   resources :bins do
  #     resource :unit, only: :create
  #   end
  # end

  namespace :api do
    resources :bins, only: [:create]

    namespace :bins do
      resources :units, only: [:show]
      resources :collections, only: [:show]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
