FactoryBot.define do
  factory :sub_comment do
    body { FFaker::Lorem.paragraph }
  end
end
