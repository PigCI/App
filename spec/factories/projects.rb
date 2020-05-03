FactoryBot.define do
  factory :project do
    name { Faker::Appliance.equipment }
    full_name { "PigCI/#{name}" }
    default_branch { 'master' }
    association :install

    after(:build) do |project|
      project.github_repository = build(
        :github_repository,
        name: project.name,
        full_name: project.full_name,
        project: project,
        install: project.install
      )
    end

    trait :high_failure_limits do
      memory_max { 700 }
      database_request_max { 75 }
      request_time_max { 50 }
    end

    trait :with_report_collection do
      last_analysed_at { Time.now }

      after(:build) do |project|
        project.report_collections = build_list(:report_collection, 1, :analysed, project: project)
      end
    end
  end
end
