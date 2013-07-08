NusHelp::Application.routes.draw do

  get "nus_modules/module_all"
  get "activities/index"
  resources :users do
    member do
      get :following, :followers , :mods, :liked_microposts, :posts
      patch :json_upload
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
      get :likers , :helpers
    end
  end
  resources :activities
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :likeships
  resources :module_followings, only: [:new, :create, :destroy, :insertModules]
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
  match '/nus_modules/module_all', to: 'nus_modules#module_all', via: 'get'
  match '/nus_modules/(:id)/module_followings', to: 'module_followings#create', via: 'POST'
  match '/nus_modules/(:id)/module_followings_delete', to: 'module_followings#destroy', via: 'POST'
  
  match '/post_click', to: 'microposts#addClickCount', via: 'POST'
  match '/nus_modules/post_click', to: 'microposts#addClickCount', via: 'POST'
  match '/users/(:id)/post_click',to: 'microposts#addClickCount', via: 'POST'
  
  match '/notification_click', to: 'activities#updateStatus', via: 'POST'

  match '/feedback_helpRec', to: 'help_recs#feedback', via: 'POST'

  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/privacy', to: 'static_pages#privacy'

  get '/search',  to: 'search#show'
  get '/search/:term',  to: 'search#show_term'
end
