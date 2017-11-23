Rails.application.routes.draw do
  devise_for :users

  resources :mail_sets do
    resources :mails
  end

  #temporary root to mail sets index page
  root to: "mail_sets#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
