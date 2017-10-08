Rails.application.routes.draw do
  get 'users/index'

  get '/' => 'home#top'

  resources :events do
    member do
      post 'join'
      post 'leave'
    end
    collection do
      get 'search'
    end
  end
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  resources :users, :only => [:index]

  # blockの最後に以下を追加
  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
