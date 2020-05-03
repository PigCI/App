require 'rails_helper'

feature 'Projects - Edit', type: :feature do
  let(:user) { create(:user, :with_install) }
  let(:project) { create(:project, :with_report_collection, install: user.installs.first) }
  let(:project_edit_attributes) do
    %i[
      memory_max
      database_request_max
      request_time_max
    ]
  end

  before { sign_in user, scope: :user }

  scenario do
    visit edit_project_path(project)

    expect do
      fill_form_and_submit(
        :project,
        :update,
        attributes_for(:project, :high_failure_limits).slice(*project_edit_attributes)
      )
    end.to change { project.reload.attributes }

    expect(page).to have_content 'Project was successfully updated.'
  end
end
