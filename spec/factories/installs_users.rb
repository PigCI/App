FactoryBot.define do
  factory :installs_user do
    association :user
    association :install
    role { 'owner' }
  end
end
