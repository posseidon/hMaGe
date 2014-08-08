Hmage::Application.routes.draw do
  devise_for :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  resources :maps, only: [:index, :show, :edit, :update] do
    member do
      get 'location'
      post 'set_grids'
    end
    collection do
      post 'search'
      post 'related'
    end
  end

  match '/about', :to => redirect('/about.html')

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'maps#index'

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id))(.:format)'
end
