Rails.application.routes.draw do
  post 'markdown_previews' => 'markdown_previews#create'
  post 'checkout' => 'account_types#create'
  delete 'checkout' => 'account_types#destroy'

  devise_for :users

  resources :users
  resources :wikis
  root to: 'welcome#index'
end
