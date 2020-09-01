FactoryBot.define do
  factory :user do
    email { FFaker::Internet.safe_email }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    password { "123456" }
  end
end
