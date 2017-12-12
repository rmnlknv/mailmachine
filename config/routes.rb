Rails.application.routes.draw do
  resources :histories
  devise_for :users

  resources :mail_sets do
    resources :emails do
      get 'send_emails', to: 'emails#send_emails'
    end
  end


  #temporary root to mail sets index page
  root to: "mail_sets#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
