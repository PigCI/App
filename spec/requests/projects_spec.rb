require 'rails_helper'

describe 'Projects', type: :request do
  let(:user) { create(:user, :with_install) }
  let!(:project) { create(:project, :with_report_collection, install: user.installs.first) }

  before { sign_in user }
  
  describe 'GET /projects' do
    subject { get projects_path }

    it { expect{ subject }.to_not raise_error }
  end

  describe 'GET /projects/:id' do
    subject { get project_path(project) }

    it { expect{ subject }.to_not raise_error }
  end

  describe 'GET /projects/:id/edit' do
    subject { get edit_project_path(project) }

    it { expect{ subject }.to_not raise_error }
  end

  describe 'GET /projects/:id/setup' do
    subject { get setup_project_path(project) }

    it { expect{ subject }.to_not raise_error }
  end

  describe 'GET /projects/:id/delete' do
    subject { get delete_project_path(project) }

    it { expect{ subject }.to_not raise_error }
  end
end
