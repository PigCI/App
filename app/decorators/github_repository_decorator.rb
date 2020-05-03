class GithubRepositoryDecorator < ApplicationDecorator
  delegate_all

  def conclusion_badge_status
    'badge-light'
  end
end
