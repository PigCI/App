require 'rails_helper'

describe 'ReportCollections', type: :request do
  let(:user) { create(:user, :with_install) }
  let(:project) { create(:project, :with_report_collection, install: user.installs.first) }
  let!(:report_collection) { project.report_collections.first }
  
  before { sign_in user }

  describe 'GET /projects/:project_id/report_collections/:id' do
    subject { get project_report_collection_path(report_collection.project, report_collection) }

    it { expect{ subject }.to_not raise_error }
  end
end
