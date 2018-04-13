FactoryBot.define do
  factory :message do
    association :user
    body 'test'

    factory :invalid_message do
      body nil
    end
  end
end
