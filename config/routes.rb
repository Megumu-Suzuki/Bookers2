Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end

    collection do
    get :tigers
    end


  end
 resources :relationships, only: [:create, :destroy]

end
