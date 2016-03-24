Rails.application.routes.draw do
  root 'landing#home'
  
# LANDING PAGE PATHS
  controller 'landing' do
    get 'pricing'
    post 'contact_us'
  end

  scope module: 'landing' do
    controller 'sessions' do
      get 'sign_in', action: 'new'
      post 'login', action: 'create'
      delete 'logout',  action: 'destroy'
    end

    resources :employment_applications, only: [:new, :create, :edit, :update]
    resources :users, only: :create, path: '/sign_up' #keeps same URL when users#create returns errors
    get 'sign_up' => 'users#new'
    get 'account_activation/:token', to: 'users#activation', as: 'account_activation'
  end

# DASHBOARD PATHS - all nested under facilities to provide :facility_id
  get 'facilities/:facility_id/dashboard', to: 'dashboard#index', as: 'dashboard'
  scope module: 'dashboard' do
    resources :users, only: :update, path: '/my_account'
    get 'my_account' => 'users#edit'
    resources :facilities do
      get 'receive_payments'  => 'payments#receive_payments'
      get 'deposit_payments'  => 'payments#deposit_payments'
      post 'receive_payments' => 'payments#create_many'
      post 'deposit_payments' => 'payments#update_many'

      controller 'staff' do
        post 'create_staff', action: 'create' #resolves singular/plural staff routing conflict; resources path defaults to 'show'
        post 'find_staff', action: 'find_staff'
        post 'add_staff', action: 'add_staff'
        post 'remove_staff/:id', action: 'remove_staff'
      end
      resources :employment_applications, only: [:index, :show, :update]
      resources :invoices
      resources :payments
      resources :residents
      resources :staff
      resources :maintenance_requests
      resources :residents
      resources :facilities_users, only: [:create, :destroy]
    end
  end
end
