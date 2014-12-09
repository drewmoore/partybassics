Rails.application.routes.draw do
  #
  # HEY! SECURITY CHECK!!!
  #
  # Comment out the lines below to prevent hooligans from creating new accounts and wrecking the site
  #
  match 'users/' => redirect('/'), via: [:post, :delete]
  match 'users/sign_up' => redirect('/'), via: [:get, :post]

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root :to => 'welcome#index'
      get 'events/display' => 'events#display'
      get 'events/display-one/:id', to: 'events#display_one'
      resources :pages
      resources :contents
      resources :graphics
      resources :events
      get '/controls', to: 'controls#index'
      post '/pages/add-content', to: 'pages#add_content'
      post '/pages/remove-content', to: 'pages#remove_content'
      post '/pages/add-graphic', to: 'pages#add_graphic'
      post '/pages/remove-graphic', to: 'pages#remove_graphic'
      get '/purchases', to: 'purchases#index'
      get '/purchases/per-event/:id', to: 'purchases#event_purchases'
      get '/purchases/per-event/:id/email/:email_search_string', to: 'purchases#event_purchases'
      get '/purchases/per-event/:id/conf/:conf_search_string', to: 'purchases#event_purchases'
      get '/purchases/per-event/:id/lastfour/:lastfour_search_string', to: 'purchases#event_purchases'
      get '/emails/new', to: 'emails#new'
      get '/emails/change', to: 'emails#change'
      get '/emails/event', to: 'emails#event'
      post '/emails/create', to: 'emails#create'
      post '/emails/event', to: 'emails#send_event'
    end
    unauthenticated :user do
      root 'welcome#index', as: :unauthenticated_root
      get 'events/display' => 'events#display'
      get 'events/display-one/:id', to: 'events#display_one'
      get '/pages/(*all)', to: redirect('/')
      get '/contents/(*all)', to: redirect('/')
      get '/graphics/(*all)', to: redirect('/')
    end
  end

  get 'about-us' => 'welcome#about_us'
  resources :charges
  get '/charges/new/:id', to: 'charges#new'
  get '/events/sold-out/:id', to: 'events#sold_out'
  post '/contacts/create', to: 'contacts#create'


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
