require 'rails_helper'

describe 'Reports', type: :request do
  let(:user) { create(:user, :with_install) }
  let(:project) { create(:project, :with_report_collection, install: user.installs.first) }
  let(:report_collection) { project.report_collections.first }
  let!(:report){ create(:report, report_collection: report_collection) }
  
  before { sign_in user }

  describe 'GET /projects/:project_id/report_collections/:report_collection_id/:id' do
    subject { get project_report_collection_report_path(report.project, report.report_collection, report) }

    it { expect{ subject }.to_not raise_error }
  end
end
