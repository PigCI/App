class ReportDecorator < ApplicationDecorator
  decorates_association :report_collection

  delegate_all

  def max_with_unit
    max + h.content_tag(:small, unit)
  end

  def limit_with_unit
    project.send("#{report.profiler}_max").to_i.to_s.html_safe + h.content_tag(:small, unit)
  end

  def min_with_unit
    min + h.content_tag(:small, unit)
  end

  def change_percentage_with_unit
    change_percentage.html_safe + h.content_tag(:small, '%')
  end

  def max
    h.number_with_precision(object.max / object.unit_scaling_modifier, precision: 0)
  end

  def min
    h.number_with_precision(object.min / object.unit_scaling_modifier, precision: 0)
  end

  def change_percentage
    object.max_difference_from_default_branch.round(2).to_s
  end

  def change_percentage_with_unit
    change_percentage.html_safe + h.content_tag(:small, '%')
  end

  def total_requests
    h.number_with_precision(object.total_requests, precision: 0)
  end

  def change_percentage_badge_status
    return 'badge-success' if conclusion_success?
    return 'badge-danger' if conclusion_failure?

    'badge-light'
  end

  def profiler
    Report.human_enum_name(:profiler, object.profiler)
  end

  def conclusion
    GithubCheckSuite.human_enum_name(:conclusion, object.conclusion)
  end
end
