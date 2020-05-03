FactoryBot.define do
  factory :report_collection do
    association :project

    commit_sha1 { 'a2ff0ad0183dae5118b6b3214536b2d695b1c865\n' }
    branch { 'master' }

    after(:build) do |report_collection|
      report_collection.reports << build(:report, report_collection: report_collection, profiler: :memory)
      report_collection.reports << build(:report, report_collection: report_collection, profiler: :request_time)
      report_collection.reports << build(:report, report_collection: report_collection, profiler: :database_request)
    end

    trait :analysed do
      last_analysed_at { Time.now }
    end
  end
end
