class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable, :omniauth_providers =>[:facebook]

  #creo un nuevo metodo en el modelo 
  def self.from_omniauth(auth)
    #lo que hago en este where es buscar en el modelo un user que tenga ese provider y ese uid la funcion 
    #first_or_create hace que si no lo encuentra cree uno nuevo o si no toma el primero
    where(provider: auth[:provider],uid: auth[:uid]).first_or_create do |user|
      if auth[:info]
        user.email = auth[:info][:email]
        user.name = auth[:info][:name]
      end
      #Crea un password generico 
      user.password = Devise.friendly_token[0,20]
    #2 tipos de metodos de clase , de instancia 
    # los metodo de clase se llama asi User.from_omniauth()
    # instancia user = user.frommetodo 
    end
  end
end
