class ProjectDecorator < ApplicationDecorator
  delegate_all

  def conclusion_badge_status
    return 'badge-warning' unless object.lastest_default_branch_report_collection?

    return 'badge-success' if object.lastest_default_branch_report_collection.conclusion_success?
    return 'badge-danger' if object.lastest_default_branch_report_collection.conclusion_failure?

    'badge-light'
  end
end
