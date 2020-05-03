# frozen_string_literal: true

require 'rails_helper'

describe 'Webhooks - Github - Installation - deleted', type: :request do
  let(:headers) do
    {
      CONTENT_TYPE: 'application/json',
      HTTP_X_GITHUB_EVENT: 'installation'
    }
  end

  let(:request_body) do
    Rails.root.join('spec', 'fixtures', 'files', 'webhooks', 'github', 'installation', 'deleted.json').read
  end

  subject do
    post webhooks_github_index_url(subdomain: :webhooks), params: request_body, headers: headers
  end

  context 'Install is present in the system' do
    let!(:install) { create(:install, :with_user, :with_project) }

    it 'removes the install, and its child objects' do
      expect { subject }.to change(Install, :count).from(1).to(0)
        .and change(Identity, :count).by(0)
        .and change(User, :count).by(0)
        .and change(GithubRepository, :count).from(1).to(0)
        .and change(Project, :count).from(1).to(0)
    end
  end
end
