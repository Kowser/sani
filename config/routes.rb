Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'login', to: 'devise/sessions#new'
  end

# ALL PATHS NESTED UNDER FACILITIES - provides @current_facility id
  resources :facilities do
    controller 'staff' do
      post 'create_staff', action: 'create' #resolves singular/plural staff routing conflict; resources path defaults to 'show'
      post 'find_staff', action: 'find_staff'
      post 'add_staff', action: 'add_staff'
      post 'remove_staff/:id', action: 'remove_staff'
    end

    get 'dashboard', to: 'dashboard#index'
    post 'receive_payments', to: 'invoices#receive_payments'
    post 'deposit_payments',to: 'payments#deposit_payments'


    resources :invoices
    resources :payments
    resources :staff
    resources :maintenance_requests
    resources :residents
    resources :facilities_users, only: [:create, :destroy]
  end
end
