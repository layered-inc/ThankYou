FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.co.jp" }
    sequence(:name) { |n| "user#{n}" }
    password 'test1234'
    password_confirmation 'test1234'

    factory :confirmed_user do
      after(:create)
    end
  end
end
