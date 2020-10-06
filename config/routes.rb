Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, :only => [:show, :index]

  root "pages#home"

  resources :articles do
    resources :contributors, :only => [:index, :destroy] do
      get 'add_contributor_to_article', on: :member
    end

    resources :article_bodies, :except => [:index] do
      get 'make_stable', on: :member
    end
  end
end
