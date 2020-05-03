class ReportCollectionDecorator < ApplicationDecorator
  delegate_all

  def summary
    [branch, commit_sha1].join(' ').html_safe
  end

  def commit_sha1
    h.content_tag :span, title: object.commit_sha1 do
      object.commit_sha1[0, 7]
    end
  end

  def last_analysed_at
    if object.last_analysed_at.present?
      time_ago_in_words(:last_analysed_at)
    else
      '-'
    end
  end

  def conclusion
    GithubCheckSuite.human_enum_name(:conclusion, object.conclusion)
  end
end
