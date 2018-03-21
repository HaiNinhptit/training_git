Rails.application.routes.draw do
  devise_for :users,
  controllers:{omniauth_callbacks: "users/omniauth_callbacks"}
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
