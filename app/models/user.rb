class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable, :omniauth_providers =>[:facebook]


  #Creo validaciones dentro del backend en rails
  # todas las validaciones estan en la siguiente pagina: http://guides.rubyonrails.org/active_record_validations.html
  # precense: true => no puede ser nulo ni tener un string vacio
  # uniqueness: true => el username no pued repetirse en la DB
  # acceptance: true => se usa para los booleans  si se asigna true el bool debe ser true para pasar sino no pasa
  # numericality: true  => solo acepta numeros
  # numericality:{only_integer:true} solo acepta numeros enteros
  # length: {minimum: 3, maximum:12} => define minimos y maximos de caracteres
  # inclusion: {in:["F","M"]} => Acepta solo si el valor esta dentro de los especificados del in
  validates :username, presence: true,uniqueness: true,length: {in: 3..12}
  # validaciones con custom methods
  validate :validate_username_regex

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
  private
    def validate_username_regex
      # la forma en que rails valida el metodo es si desde aqui mando un false y la segunda es si el arreglo de errores tiene algo
      # un ejemplo dummy de agregar un test en donde el username no debe de empezar con un guion o con algun numero
      unless username =~ /\A[a-zA-Z]*[a-zA-Z][a-zA-Z0-9_]*\z/
        # errors.add(columna donde sucedio el error , mensaje del motivo del fallo)
        errors.add(:username,"The username must be start with a letter")
        errors.add(:username,"The username can only contain _, letters and numbers")
      end
    end
end
