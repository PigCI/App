FactoryBot.define do
  factory :github_repository do
    install
    github_id { 146505263 }
    name { "App" }
    full_name { "PigCI/App" }

    trait :with_github_check_suite do
      after(:build) do |github_repository|
        github_repository.github_check_suites = build_list(:github_check_suite, 1, github_repository: github_repository)
      end
    end
  end
end
