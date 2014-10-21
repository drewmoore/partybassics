Rails.application.routes.draw do
  #
  # HEY! SECURITY CHECK!!!
  #
  # Comment out the lines below to prevent hooligans from creating new accounts and wrecking the site
  #
  # match 'users/' => redirect('/'), via: [:post, :delete]
  # match 'users/sign_up' => redirect('/'), via: [:get, :post]

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root :to => 'welcome#index'
      resources :pages
      resources :contents
      resources :graphics
      get '/controls', to: 'controls#index'
      post '/pages/add-content', to: 'pages#add_content'
      post '/pages/remove-content', to: 'pages#remove_content'
      post '/pages/add-graphic', to: 'pages#add_graphic'
      post '/pages/remove-graphic', to: 'pages#remove_graphic'
    end
    unauthenticated :user do
      root 'welcome#index', as: :unauthenticated_root
      get '/pages/(*all)', to: redirect('/')
      get '/contents/(*all)', to: redirect('/')
      get '/graphics/(*all)', to: redirect('/')
    end
  end

  get 'trivia/' => 'welcome#trivia'

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
