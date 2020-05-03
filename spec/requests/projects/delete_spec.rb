require 'rails_helper'

describe 'Projects - Delete', type: :request do
  let(:user) { create(:user, :with_install) }
  let!(:project) { create(:project, :with_report_collection, install: user.installs.first) }

  before { sign_in user }

  describe 'DELETE /projects/:id/delete' do
    subject { delete project_path(project) }

    it do
      expect { subject }.to change(Project, :count).from(1).to(0)
                                                   .and change { response&.status }.to(302)
    end
  end
end
