FactoryGirl.define do
  factory :user do
    password "12345678"
    # con sequence podemos crear usuarios secuenciales para no tener el problema de crear 2 emails iguales
    sequence (:email){|n| "dummy_#{n}@factory.com"}
  end
end
