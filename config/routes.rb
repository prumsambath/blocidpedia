Rails.application.routes.draw do
  post 'markdown_previews' => 'markdown_previews#create'
  delete 'checkout' => 'checkouts#destroy'

  devise_for :users

  resources :users
  resources :wikis
  root to: 'welcome#index'
  resources :checkouts, only: [:new, :index]
end
