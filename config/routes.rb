Rails.application.routes.draw do
  resources :movies, :except => [:show]
  get '/movies/twenties' => 'movies#twenties' 
  get '/movies/thirties' => 'movies#thirties'
  get '/movies/forties' => 'movies#forties' 
  get '/movies/fifties' => 'movies#fifties'
  get '/movies/sixties' => 'movies#sixties'
  get '/movies/seventies' => 'movies#seventies'
  get '/movies/eighties' => 'movies#eighties'
  get '/movies/nineties' => 'movies#nineties'  
  get '/movies/aughts' => 'movies#aughts'
  get '/movies/twentytens' => 'movies#twentytens'
  
  get '/movies/search' => 'movies#search'
  post '/movies' => 'movies#create'
  get '/movies/:id' => 'movies#show', as: 'movie_path'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
