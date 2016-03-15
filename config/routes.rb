Rails.application.routes.draw do
  root 'landing#home'

# LANDING PATHS
  controller 'landing' do
    get 'home'
    get 'sign_up'
    post 'contact_us'
  end 

  resources :employment_applications, only: [:new, :create, :edit, :update]
  resources :users, only: [:create]

# DASHBOARD PATHS

  # ALL PATHS NESTED UNDER FACILITIES - provides @current_facility id
  resources :facilities do
    controller 'staff' do
      post 'create_staff', action: 'create' #resolves singular/plural staff routing conflict; resources path defaults to 'show'
      post 'find_staff', action: 'find_staff'
      post 'add_staff', action: 'add_staff'
      post 'remove_staff/:id', action: 'remove_staff'
    end

    get 'dashboard'         => 'dashboard#index'
    get 'receive_payments'  => 'payments#receive_payments'
    get 'deposit_payments'  => 'payments#deposit_payments'
    post 'receive_payments' => 'payments#create_many'
    post 'deposit_payments' => 'payments#update_many'

    resources :employment_applications, only: [:index, :show, :update]
    resources :invoices
    resources :payments
    resources :staff
    resources :maintenance_requests
    resources :residents
    resources :facilities_users, only: [:create, :destroy]
  end
end
