FactoryBot.define do
  factory :comment do
    body { FFaker::Lorem.paragraph }
  end
end
