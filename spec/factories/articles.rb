FactoryBot.define do
  factory :article do
    title { "MyTitle" }
    teaser { "MyTeaser" }
    body { "MyLongBodyText" }
    category { 1 }
  end
end
