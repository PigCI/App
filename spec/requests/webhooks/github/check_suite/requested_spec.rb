# frozen_string_literal: true

require 'rails_helper'

describe 'Webhooks - Github - Check Suite - requested', type: :request, vcr: true do
  let(:headers) do
    {
      CONTENT_TYPE: 'application/json',
      HTTP_X_GITHUB_EVENT: 'check_suite'
    }
  end

  let(:request_body) do
    Rails.root.join('spec', 'fixtures', 'files', 'webhooks', 'github', 'check_suite', 'requested.json').read
  end

  let!(:install) { create(:install, :with_github_repository) }

  subject do
    post webhooks_github_index_url(subdomain: :webhooks), params: request_body, headers: headers
  end

  context 'With github github repository' do
    let(:install_service) { double :install_service }

    it 'creates the github check suite and tells github it is pending' do
      expect(InstallService).to receive(:new).with(install).and_return(install_service)
      expect(install_service).to receive(:create_status).and_return(true)

      expect { subject }.to change(GithubCheckSuite.where(conclusion: :action_required), :count).by(1)
    end

    context 'and a project also' do
      let!(:install) { create(:install, :with_project) }

      it 'creates the github check suite and tells github it is pending' do
        expect(InstallService).to receive(:new).with(install).and_return(install_service)
        expect(install_service).to receive(:create_status).and_return(true)

        expect { subject }.to change(GithubCheckSuite.where(conclusion: :pending), :count).by(1)
      end
    end
  end
end
