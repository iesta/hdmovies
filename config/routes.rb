Hdmovies::Application.routes.draw do
  get "home/index"

  get "home/chat"

  resources :requests do
    member do
      post 'fill'
    end
  end

  resources :users do
    member do
      post 'add_to_list'
      post 'remove_from_list'
      get 'remove_from_list'
      get  'critics'
      get  'mustsee'
    end
  end
  
  resources :user_sessions
  
  resources :critics do
    collection do
      get :rss
    end
  end

  resources :movies do
    collection do
      get :rss
      get :autocomplete_movie_title
    end
    member do
      get :freebase
    end
  end
  
  resources :genres
  
  # some non restful routes for movies
  match 'movies_grid'   => 'movies#grid'
  match 'movies_sgrid'  => 'movies#sgrid'
  match 'movies_full'   => 'movies#full'
  match 'stats'         => 'movies#stats'
  match 'year(/:id)'    => 'movies#year' , :as => :year
  
  # config/routes.rb
  #map.login "login", :controller => "user_sessions", :action => "new"
  #map.logout "logout", :controller => "user_sessions", :action => "destroy"

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  root :to => "home#index" #controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
