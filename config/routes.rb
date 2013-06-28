NusHelp::Application.routes.draw do

  resources :search

  get "activities/index"
  resources :users do
    member do
      get :following, :followers , :mods, :liked_microposts
    end
  end
  
  resources :nus_modules do
    member do
      get :mod_followers
    end
  end

  resources :microposts, only: [:create, :destroy, :show] do
    resources :comments
    member do
      get :likers 
    end
  end
  resources :activities
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :likeships
  resources :module_followings, only: [:new, :create, :destroy, :insertModules]
  resources :search
  resources :help_recs

  root to: 'static_pages#home'
  match '/module_list', to: 'nus_modules#autoCompJson', via: 'get'

  match '/createmod', to: 'nus_modules#new', via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/signupmod', to: 'module_followings#new',  via: 'get'
  match '/insertModules', to: 'module_followings#insertModules',  via: 'get'
  match '/update_helpRec', to: 'help_recs#update', via: 'post'
  match '/module_followings', to: 'module_followings#create', via: 'POST'
  match '/module_followings_delete', to: 'module_followings#destroy', via: 'POST'
  match '/nus_modules/(:id)/module_followings', to: 'module_followings#create', via: 'POST'
  match '/nus_modules/(:id)/module_followings_delete', to: 'module_followings#destroy', via: 'POST'
  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
