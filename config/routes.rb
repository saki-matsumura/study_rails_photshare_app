Rails.application.routes.draw do
  root "posts#index"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :posts do
    collection do
      post :confirm
    end
  end
  resources :favorites, only: [:create, :destroy]
end
