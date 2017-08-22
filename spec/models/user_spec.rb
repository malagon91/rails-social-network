require 'rails_helper'
# UNIT TEST
# Aqui podemos implementar nuestros test de la app
RSpec.describe User, type: :model do
  # Dummy example
  it "should work test" do
    expect(true).to eq(true)
  end
  #Estas validaciones validan lo que agregamos en el modelo user con la sig linea
#     validates :username, presence: true,uniqueness: true,length: {in: 3..12}
  # Este test y el metodo should fueron importados por las gemas que agregue, y con ella vienen los metodos que nos ayudan a
  # facilitar las validaciones del modelo aqui valido que el modelo  user tenda la validacion de precense
  it {should validate_presence_of :username }
  # Este motodo valida si el username esta siendo validado para que no se repita nunca
  it {should validate_uniqueness_of :username }
  # Valida que la longitud no sea menor a 3 ni mayor a 12
  it {should validate_length_of(:username).is_at_least(3).is_at_most(12) }
  describe "#validate_username_regex" do
    # funciona como un beforeeach asi no tengo que crear el user en cada test
    let(:user){FactoryGirl.build(:user)}
    it "should not allow username with numbers at the beginning" do
      user.username = "9asfas"
      expect(user.valid?).to be_falsy
    end
    it 'should  not contain special characters' do
      user.username = "9asfas*"
      expect(user.valid?).to be_falsy
    end

  end
end
