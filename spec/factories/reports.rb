FactoryBot.define do
  factory :report do
    association :report_collection
    project { nil }

    profiler { 'memory' }

    max { 100.0 }
    max_difference_from_default_branch { 0.0 }
    min { 50.0 }
    min_difference_from_default_branch { 0.0 }
    total_requests { 2 }

    analysed_at { Time.now }
    branch { 'master' }

    raw_data do
      fixture_file_upload 'files/memory-report.json', 'text/json'
    end
  end
end
