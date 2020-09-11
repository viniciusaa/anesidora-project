FactoryBot.define do
  factory :article_body do
    body { FFaker::Lorem.paragraph }
  end
end
