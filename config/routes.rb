Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, :only => [:show, :index]

  root "pages#home"

  resources :articles do
    get 'change_privacy', on: :member

    resources :contributors, :only => [:index, :destroy] do
      get 'add_contributor_to_article', on: :member
    end

    resources :article_bodies, :except => [:index] do
      get 'make_stable', on: :member
    end

    resources :comments, :only => [:index, :create, :destroy] do
      resources :sub_comments, :only => [:new, :create, :destroy]
    end
  end
end
