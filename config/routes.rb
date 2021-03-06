Rails.application.routes.draw do
  root "homes#index"

  get "sign_up", to: "homes#index"
  get "sign_in", to: "homes#index"
  get "articles/new", to: "homes#index"
  get "articles/draft", to: "homes#index"
  get "articles/drafts/:id/edit", to: "homes#index"
  get "articles/:id/edit", to: "homes#index"
  get "articles/:id", to: "homes#index"
  get "mypage", to: "homes#index"


  namespace :api, format: "json" do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth", controllers: {
        registrations: "api/v1/auth/registrations",
        sessions: "api/v1/auth/sessions",
      }
      namespace :articles do
        resources :drafts, only: [:index, :show]
      end
      namespace :current do
        resources :articles, only: [:index]
      end
      resources :articles
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
