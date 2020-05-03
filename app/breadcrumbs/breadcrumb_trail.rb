class BreadcrumbTrail < Croutons::BreadcrumbTrail
  def landing_index
    breadcrumb(t('.title', scope: %w[meta_tags landing index]), root_path)
  end

  def landing_contact_us
    breadcrumb(t('.title', scope: %w[meta_tags landing contact_us]), contact_us_path)
  end

  def landing_roadmap
    breadcrumb(t('.title', scope: %w[meta_tags landing roadmap]), roadmap_path)
  end

  def landing_api
    breadcrumb(t('.title', scope: %w[meta_tags landing api]), api_path)
  end

  def projects_index
    breadcrumb(Project.name.pluralize, projects_path)
  end

  def projects_show
    projects_index
    breadcrumb(objects[:project], project_path(objects[:project]))
  end

  def projects_edit
    projects_index
    breadcrumb(objects[:project], project_path(objects[:project]))
    breadcrumb("Edit #{Project.name}", edit_project_path(objects[:project]))
  end

  def projects_setup
    projects_index
    breadcrumb(objects[:project], project_path(objects[:project]))
    breadcrumb('Setup', setup_project_path(objects[:project]))
  end

  def projects_delete
    projects_index
    breadcrumb(objects[:project], project_path(objects[:project]))
    breadcrumb('Delete', delete_project_path(objects[:project]))
  end

  def projects_new
    projects_index
    breadcrumb("Add #{Project.name}")
  end

  def report_collections_show
    projects_show
    breadcrumb(objects[:report_collection], project_report_collection_path(objects[:report_collection].project, objects[:report_collection]))
  end

  def reports_show
    report_collections_show
    breadcrumb(objects[:report], project_report_collection_report_path(objects[:report].project, objects[:report].report_collection, objects[:report]))
  end

  def billings_show
    breadcrumb('Billing', billing_path)
  end

  def settings_show
    breadcrumb('Settings', settings_path)
  end

  def setup_githubs_show
    breadcrumb(t('.title', scope: %w[meta_tags setup/githubs show]), setup_github_path)
  end

  def legals_privacy_policy
    breadcrumb(t('.title', scope: %w[meta_tags legals privacy_policy]), privacy_policy_path)
  end

  def legals_terms_of_service
    breadcrumb(t('.title', scope: %w[meta_tags legals terms_of_service]), terms_of_service_path)
  end

  def legals_cookie_policy
    breadcrumb(t('.title', scope: %w[meta_tags legals cookie_policy]), cookie_policy_path)
  end

  def legals_subprocessors
    breadcrumb(t('.title', scope: %w[meta_tags legals subprocessors]), subprocessors_path)
  end

  def legals_github_integration_deprecation_notice
    breadcrumb(t('.title', scope: %w[meta_tags legals github_integration_deprecation_notice]), github_integration_deprecation_notice_path)
  end
end
