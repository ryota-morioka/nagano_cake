Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    get "/about"=>"homes#about"
    resources :items, only: [:index, :show]
    resource :customers,only: [] do
      get "mypage"=>"customers#show"
      get "information/edit"=>"customers#edit"
      patch "information"=>"customers#update"
      get "confirm_withdraw"=>"customers#confirm_withdraw"
      patch "withdrawal"=>"customers#withdrawal"
      get 'lookup_address', to: 'customers#lookup_address'
    end
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete "destroy_all"=>"cart_items#destroy_all"
      end
    end



        post 'orders/confirm' => 'orders#confirm'
        get 'orders/thanks' => 'orders#thanks'
        get 'recipient_address', to: 'orders#recipient_address'
   resources :orders, only: [:new, :create, :index, :show]
  end


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:passwords], controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update] do
      get "orders" => "customers#orders"
    end
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
