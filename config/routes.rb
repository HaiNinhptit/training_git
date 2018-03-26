Rails.application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  resources :products
  resources :carts
  post 'user/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  get 'user/confirm_cart', to: 'products#confirm_cart', as: 'confirm_cart'
  patch 'user/cart_product/edit/:id', to: 'cart_products#edit', as: 'cart_products_edit'
  delete 'user/cart_product/delete/:id', to: 'cart_products#destroy', as: 'cart_products_delete'
  delete 'delete_element_session_cart/:id', to: 'products#delete_element_session_cart', as: 'delete_element_session_cart'
  patch 'edit_element_session_cart/:id', to: 'products#edit_element_session_cart', as: 'edit_element_session_cart'
  get 'order', to: 'users#order', as: 'order'
  post 'order_confirm/:id', to: 'users#order_confirm', as: 'order_confirm'
  get 'user/profile', to: 'users#profile', as: 'profile'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
