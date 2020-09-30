Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, :only => [:show, :index]
  root "pages#home"
  resources :articles do
    resources :article_bodies
    resources :contributors, :only => [:index, :update, :destroy]
  end
end
