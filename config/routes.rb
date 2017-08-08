Rails.application.routes.draw do
  devise_for :users, controllers:{
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  #asignamos los retornos de Fb a un controlles amoniauth_callbacks
  #cuando la url sea esta asigna el controller y el metodo asignado
  post "/custom_sign_up", to: "users/omniauth_callbacks#custom_sign_up"
  root 'main#home'
  #root es la que accesedemos en el  index
  #1 Manda la peticion a Fb 
  #2 Fb retorna a nuestra app 
  #3 Procesar la info de Fb
  #4 autenticar al user o crear un nuevo user


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
