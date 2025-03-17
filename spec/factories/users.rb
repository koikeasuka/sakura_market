FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'passpass' }
    confirmed_at { '2025-01-01 00:00:00' }
  end
end
