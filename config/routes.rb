Mycrm::Application.routes.draw do

  resources :subsities
  resources :public_bills
  resources :lead_history_statuses
  resources :lead_interviews, only: [:update]
  resources :progresses do
    collection do
      get "data"
      post "update"
      post "update_period"
    end
    member do
      get "period"
    end
  end

  resources :leads do
    collection do
      match 'search' => 'leads#search', via: [:get, :post], as: :search
      get "mylist"
      get "tasks"
      get "add_tag"
      post "add_tag_finish"
      get "name"
      post "up_column"
      get "address"
      get "reject_list"
    end
    member do
      get "add_mylist"
      get "add_flg"
      patch "update_tasks"
      get "add_task"
      get "contract"
      get "find"
    end
  end

  resources :lead_histories do 
    collection do
      get "total_all"
      get "total"
      get "zip"
      get "shipped"
      get "approach"
    end
    member do
      get "sent"
      get "remove_attachment"
    end
  end

  devise_for :users
  scope "/admin" do
    resources :users do
      collection do
        get "non_auth"
      end
      member do
        get "lock"
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

  resources :public_estimates do 
    member do
      get 'flag/:type' , :action => "flag"
    end
  end

  resources :estimates do 
    member do
      get 'flag/:type' , :action => "flag"
    end
  end

  resources :campaigns, :invoices, :client_orders, :clients

  resources :teacher_order_lines, only: [:index] do
    member do
      get 'flag/:type' , :action => "flag"
    end
  end

  resources :teacher_orders do
    member do
      get 'flag/:type' , :action => "flag"
      get 'active'
      get 'cancel'
      get 'report'
    end
  end

  resources :teachers
  get 'teachers/update/:id/:type' => 'teachers#up_bool'
  get 'teachers_flag' => 'teachers#flag'

  resources :order_sheets do
    collection do
      get 'check/:id/:status' => 'order_sheets#check'
    end
    member do
      get "report"
    end
  end
  resources :order_sheet_lines, only: [:index] do
    member do
      get 'flag/:type' , :action => "flag"
    end
  end


  resources :contacts, :only => [:destroy]    

  #コース
  resources :courses  do
    collection do
      get 'calendar'
      put 'update/:id' => 'courses#up_name'  
      get 'update/:id/:type' => 'courses#up_bool'
      get 'google'
      get 'list'
    end
    member do
      get "attend"
    end
  end

  resources :course_tasks, only: [:destroy,:index] do
    collection do
      post 'change'
    end
  end

  resources :subsity_tasks, only: [:destroy,:index]

  #会社名
  resources :companies do
    collection do
      get "invoice"
      get "label"
      get "pdf"
      get "name"
      get "address"
    end
    
    member do
      get 'contact_delete'
      get "find"
    end
  end

  root :to => 'leads#index'
end

#  get 'current' => 'users#current'
#  get 'login' => 'users#login'

