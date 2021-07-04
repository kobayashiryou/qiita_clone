Rails.application.routes.draw do
  get "homes/index"
  root "homes#index"

  namespace :api, format: "json" do
    namespace :v1 do
      resources :articles
      mount_devise_token_auth_for "User", at: "auth", controllers: {
        registrations: "api/v1/auth/registrations",
        sessions: "api/v1/auth/sessions",
      }
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
