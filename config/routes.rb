Rails.application.routes.draw do
  post 'markdown_previews' => 'markdown_previews#create'
  delete 'checkout' => 'checkouts#destroy'

  devise_for :users

  resources :users
  resources :wikis do
    resources :collaborations, except: [:edit, :update]
  end
  resources :checkouts, only: [:new, :index]

  root to: 'welcome#index'
end
