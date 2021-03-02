FactoryBot.define do
  factory :article do
    title { "MyString" }
    teaser { "MyText" }
    body { "MyText" }
    category { 1 }
  end
end
