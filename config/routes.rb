Rails.application.routes.draw do

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]

  resource :session, controller: "sessions", only: [:new, :create, :create_from_omniauth]

  resources :users, controller: "users", only: [:create, :show, :edit, :update] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :listings, controller: "listings", only: [:new, :create, :edit, :update, :show, :index, :destroy]
  get "/my_listings" => "listings#index_user", as: "index_user_listing"

  resources :reservations, controller: "reservations", only: [:new, :create, :edit, :update, :show, :index, :destroy]
  get "/my_reservations" => "reservations#index_user", as: "index_user_reservation"
  get "/errors_reservations" => "reservations#errors_user", as: "errors_user_reservation"

  root 'home#index'

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "new_signup"

  if Clearance.configuration.allow_sign_up?
    get '/sign_up' => 'clearance/users#new', as: 'sign_up'
  end

  match "/auth/:provider/callback" => "sessions#create_from_omniauth", via: :get 

  # mount FullcalendarEngine::Engine => "/fullcalendar_engine"

  # get 'listings/new'

  # get 'listings/create'

  # get 'listings/edit'

  # get 'listings/view'

  # get 'listings/index'

  # get 'listings/update'

  # get 'home/index'

  # resources :users, controller: 'users', only: 'create'



  # get '/signup', to: "registrations#new", as: 'new_signup'
  # post '/signup', to: "registrations#create", as: 'signup'

  # get '/login', to: "sessions#new", as: 'new_login'
  # post '/login', to: "sessions#create", as: 'login'
  # delete '/logout', to: "sessions#destroy", as: 'logout'

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
