Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, :only => [:show, :index]
  
  root "pages#home"

  resources :articles do
    resources :contributors, :only => [:index, :update, :destroy]

    resources :article_bodies, :except => [:index]
    resources :article_bodies do
      member do
        get 'make_stable'
      end
    end
  end
end
