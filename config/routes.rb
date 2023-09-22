Rails.application.routes.draw do
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  devise_for :customers,controllers: {
  sessions: "public/sessions",
  registrations: 'public/registrations',
}

  scope module: :public do
    root to: 'homes#top'
    get 'about' => "homes#about"
    resources :items, only: [:index, :show]
    
    patch 'customers/withdrawal' => "customers#withdrawal"
    get 'customers/confirm_withdrawal' => "customers#confirm_withdrawal"
    resources :customers, only: [:show, :edit, :update]
    
    resources :cart_items, only: [:index, :update, :create, :destroy]
    delete 'cart_items/destroy_all' => "cart_items#destroy_all"
    post "orders/confirm" => "orders#confirm"
    get "orders/complete" => "orders#complete"
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :genres, only: [:show]
  end

  namespace :admin do
    get "" => "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
