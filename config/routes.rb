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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
