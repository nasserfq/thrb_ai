Rails.application.routes.draw do
  namespace :admin do
    resources :tasks
    resources :users

    root to: "tasks#index"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get "up" => "rails/health#show", as: :rails_health_check

    passwordless_for :users
    passwordless_for :users, at: "/", as: :auth

    # Here we modify the resources :tasks block to include the custom collection route
    resources :tasks do
      collection do
        get :fetch_country_states
      end
    end
    get "about", to: "users#about"
    get "privacy_policy", to: "users#privacy_policy"
    get "terms_of_service", to: "users#terms_of_service"

    post "tasks/:id/toggle", to: "tasks#toggle"
    post "tts", to: "tasks#tts", as: :tts

    # Defines the root path route ("/")
    root "tasks#index"
  end
end
