Mycrm::Application.routes.draw do

  devise_for :users
  scope "/admin" do
    resources :users do
      collection do
        get "non_auth"
      end
    end
  end
  resources :bills do
    collection do
      get "search"
    end
    member do
      get "find"
      get 'flag/:type' , :action => "flag"
    end
  end

  resources :billing_plans do 
    collection do
      get "sales"
    end
    member do
      get 'flag/:type' , :action => "flag"
    end
  end

  resources :clients

  resources :estimates do 
    member do
      get 'flag/:type' , :action => "flag"
    end
  end

  resources :campaigns
  resources :invoices
  resources :client_orders

  resources :teacher_orders do
    member do
      get 'flag/:type' , :action => "flag"
    end
  end

  resources :teachers
  get 'teachers/update/:id/:type' => 'teachers#up_bool'
  get 'teachers_flag' => 'teachers#flag'


  resources :industries, :task_types, :statuses
  resources :contacts, :only => [:destroy]    

  get "graphs/index"
  get "graphs/created"
  get "graphs/action"


  #コース
  resources :courses  do
    collection do
      get 'calendar'
      get 'observe'
      put 'update/:id' => 'courses#up_name'  
      get 'update/:id/:type' => 'courses#up_bool'
      get 'google'
      get 'alert'
      get 'task'
    end
  end

  #会社名
  resources :companies, except: [:show] do
    collection do
      get "search"
      get "map"
      get "invoice"
      get "label"
      get "usershow"
      get "pdf"
      get "name"
    end
    
    member do
      get 'contact_delete'
      get "client_sheet"
      get "usershow"
      get "find"
    end
  end

  #タスク
  resources :tasks
  get 'usertasks' => 'tasks#usershow'
  post 'create_task' => 'tasks#ajax_create'
  get 'task_status_change' => 'tasks#status_change'

   
  
#  get 'current' => 'users#current'
#  get 'login' => 'users#login'

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
