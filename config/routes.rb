Rails.application.routes.draw do
  devise_for :users
  root to: "offers#index"
  get "/myoffers", to: "pages#myoffers", as: "myoffers"
  get "/mybookings", to: "pages#mybookings", as: "mybookings"

  resources :offers do
    resources :bookings, only: [:new, :create, :destroy] do
      member do
        patch 'accept'
        patch 'reject'
      end
    end
  end
end
