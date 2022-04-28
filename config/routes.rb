Rails.application.routes.draw do
  get 'search/result'
  root "posts#index"

  resources :posts do
    resources :comments
  end
end
