FactoryBot.define do
  factory :admin do
    name { "Mr. Miyagi" }
    email { "user@gmail.com" }
    password { "password" }
    password_confirmation { "password" }
    role { 2 }
  end
end
