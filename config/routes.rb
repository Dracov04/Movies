Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # get '/movies' => 'movie#index'
  # get '/movies/:id' => 'movie#show'
  get '/actor/:full_name' => 'cast_members#show_by_name', as: 'name'
  #get '/' => 'movies#principal'
  root 'movies#index'
  # get '/actor' => 'cast_member#index'
  



  resources :movies do
    collection do
      get :random_movies
      get :search
      get :search_category
    end

    member do
      patch :reduce_counter
      patch :increment_counter
    end

    resources :reviews
  end

  resources :movies do
    resources :cast_members
  end

  resources :cast_members do
    resources :movies
  end

  resources :movies do
    resources :categories
  end

  resources :categories do
    resources :movies
  end

# SONGS
  resources :music do
    collection do
      get :random_songs
      get :search_song
      get :search_category
    end
  end

  resources :song do
    resources :artist
  end

  resources :artist do
    resources :songs
  end

  resources :artist do
    resources :tags
  end

  resources :tags do
    resources :artist
  end


  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
