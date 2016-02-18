Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'login', to: 'devise/sessions#new'
  end
  resources :facilities_users, only: [:create, :destroy]

  resources :facilities do
    controller 'dashboard' do
      get 'dashboard', action: 'index'
      get 'maintenance'
      # get 'applications'
      # get 'settings'
      # get 'preferences'
    end

    resources :staff
    controller 'staff' do
      post 'staff_create', action: 'create' #routing conflict requires this route!
      post 'find_staff', action: 'find_staff'
      post 'add_staff', action: 'add_staff'
      post 'remove_staff/:id', action: 'remove_staff'
    end

    resources :invoices
      post 'receive_payments', to: 'invoices#receive_payments'
    resources :payments
      post 'deposit_payments',to: 'payments#deposit_payments'
    resources :maintenance_requests

    resources :residents
  end
  
end
