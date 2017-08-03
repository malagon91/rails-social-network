Rails.application.routes.draw do
  devise_for :users
  root 'main#home'
  #root es la que accesedemos en el  index

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
