Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, :only => [:show, :index]
  root "pages#home"
  resources :articles do
    resources :article_bodies
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
