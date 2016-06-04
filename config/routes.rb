Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root :to => 'welcome#index'
      get 'events/display' => 'events#display'
      get 'events/display-one/:id', to: 'events#display_one'
      get 'events/fb-promote', to: 'events#fb_promote'
      get 'events/archive', to: 'events#archive'
      post 'events/:id/hide', to: 'events#hide'
      post 'events/:id/show', to: 'events#show'
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
      get '/contacts/metrics', to: 'contacts#metrics'
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
  post '/contacts/subscribe-this', to: 'contacts#subscribe_this'
  get '/contacts/unsubscribe/:id', to: 'contacts#unsubscribe'
  get '/contacts/subscribe', to: 'contacts#subscribe'
  patch '/contacts/update/:id', to: 'contacts#update'
  get '/privacy-policy', to: 'welcome#privacy'
end
