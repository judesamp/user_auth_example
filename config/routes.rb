Rails.application.routes.draw do

  use_doorkeeper
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :listings do
    collection do
      get :invitations
      get :favors
      get :ties
      get :flowers
      get :accessories
      get :garters
    end
  end

  resources :wishlists do 
    resources :items # makes routes like 'wishlists/1/items', which should have a page with all the items for the wishlist with id 1
    

    #pattern :wishlists/:wishlist_id/items/:id

  end


  get "github_auth" => "github#authenticate"
  get "github_auth/callback" => "github#callback"
  post "create_gist" => "github#create_gist"

  get "twitter_auth" => "twitter#authenticate"
  get "twitter_auth/callback" => "twitter#callback"

end
