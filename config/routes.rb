Rails.application.routes.draw do
  post 'markdown_previews' => 'markdown_previews#create'

  devise_for :users

  resources :wikis
  root to: 'welcome#index'
end
