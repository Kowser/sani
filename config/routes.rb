Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'login', to: 'devise/sessions#new'
  end

  resources :facilities do
    controller 'dashboard' do
      get 'dashboard', action: 'index'
      get 'maintenance'
      # get 'applications'
      # get 'settings'
      # get 'preferences'
    end

    resources :invoices
      post 'receive_payments', to: 'invoices#receive_payments'
    resources :payments
      post 'deposit_payments',to: 'payments#deposit_payments'
    resources :maintenance_requests

    resources :residents
    resources :staff
    # post 'staff_form', to: 'staff#create'
    # patch 'staff_form/:id', to: 'staff#update'
    # put 'staff_form/:id', to: 'staff#update'
    post 'find_staff', to: 'staff#find_staff'
    post 'add_staff', to: 'staff#add_staff'
  end
  
end
