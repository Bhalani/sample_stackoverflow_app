Rails.application.routes.draw do

  devise_for :users

  root 'visitors#index'

  resources :questions do
    resources :answers
  end
  resources :tags, only: [:index]

  namespace :admin do
    root 'dashboard#index'
    resources :question
    resources :tags
  end

  mount Ckeditor::Engine => '/ckeditor'
end
