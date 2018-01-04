Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'sign_in',     to: 'devise/sessions#new',     as: :new_user_session
    get 'sign_out',    to: 'devise/sessions#destroy', as: :destroy_user_session
    # delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  get 'welcome/index'
  get 'privacy_policy.htm', to: 'welcome#privacy'

  root to: 'welcome#index'
end
