FactoryBot.define do
  factory :install do
    account_login { Faker::Company.name }
    install_id { 875537 }
    app_id { 22929 }

    trait :with_user do
      after(:build) do |install|
        install.users = build_list(:user, 1, installs: [install])
      end
    end

    trait :with_project do
      after(:build) do |install|
        install.projects = build_list(:project, 1, install: install)
      end
    end

    trait :with_github_repository do
      after(:build) do |install|
        install.github_repositories = build_list(:github_repository, 1, install: install)
      end
    end
  end
end
