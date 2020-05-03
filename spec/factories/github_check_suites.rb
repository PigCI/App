FactoryBot.define do
  factory :github_check_suite do
    github_repository
    install { github_repository.install }
    github_id { 111621104 }
    head_branch { 'master' }
    head_sha { 'a2ff0ad0183dae5118b6b3214536b2d695b1c865' }
  end
end
