FactoryBot.define do
  factory :identity do
    provider { 'github' }
    sequence :uid
    association :user
  end
end
