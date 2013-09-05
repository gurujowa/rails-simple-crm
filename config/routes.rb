Mycrm::Application.routes.draw do

  resources :industries

  resources :task_types
  resources :tasks

  get "graphs/index"
  get "graphs/created"

  resources :statuses
  resources :users
  resources :contacts, :only => [:destroy]    
  resources :companies, except: [:show] do
    collection { get "search"}
  end

  get 'courses/create' => 'courses#create'  
  put 'courses/update/:id' => 'courses#up_name'  
  get 'courses/update/:id/:type' => 'courses#up_bool'  
  get 'companies/contact_delete/:id' => 'companies#contact_delete'
  get 'companies_pdf' => 'companies#pdf'
  get 'invoice' => 'companies#invoice'
  get 'companies_label' => 'companies#label'
  get 'up_postsend' => 'companies#up_postsend'
  post 'create_task' => 'tasks#ajax_create'
  get 'task_status_change' => 'tasks#status_change'
   
  
  get 'current' => 'users#current'
  get 'login' => 'users#login'

  root :to => 'companies#index'
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
