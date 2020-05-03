# frozen_string_literal: true

require 'rails_helper'

describe 'Webhooks - Github - Installation - created', type: :request, vcr: true do
  let(:headers) do
    {
      CONTENT_TYPE: 'application/json',
      HTTP_X_GITHUB_EVENT: 'installation'
    }
  end

  let(:request_body) do
    Rails.root.join('spec', 'fixtures', 'files', 'webhooks', 'github', 'installation', 'created.json').read
  end

  subject do
    post webhooks_github_index_url(subdomain: :webhooks), params: request_body, headers: headers
  end

  context 'No install, or users' do
    it 'creates install, and an oauth for the user who installed' do
      skip 'This hits the actual API - Need stub it.'
      expect { subject }.to change(Install, :count).by(1)
        .and change(Identity, :count).by(1)
        .and change(User, :count).by(1)
        .and change(GithubRepository, :count).by(1)
    end
  end
end
