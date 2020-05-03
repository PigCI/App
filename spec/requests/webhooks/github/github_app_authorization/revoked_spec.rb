# frozen_string_literal: true

require 'rails_helper'

describe 'Webhooks - Github - github app authorization - revoked', type: :request do
  let(:headers) do
    {
      CONTENT_TYPE: 'application/json',
      HTTP_X_GITHUB_EVENT: 'github_app_authorization'
    }
  end

  let(:request_body) do
    JSON.parse(Rails.root.join('spec', 'fixtures', 'files', 'webhooks', 'github', 'github_app_authorization', 'revoked.json').read).tap do |json|
      json['sender']['id'] = identity.uid
    end.to_json
  end

  subject do
    post webhooks_github_index_url(subdomain: :webhooks), params: request_body, headers: headers
  end

  context 'identity with a user' do
    let!(:user) { create(:user, :with_identity, :with_install) }
    let(:identity) { user.identities.first }
    it 'removes the user and their identity' do
      expect { subject }.to change(User, :count).from(1).to(0)
        .and change(Identity, :count).from(1).to(0)
        .and change(InstallsUser, :count).from(1).to(0)
        .and change(Install, :count).by(0)
    end
  end

  context 'identity without a user' do
    let!(:identity) { create(:identity) }
    it 'removes the user and their identity' do
      expect { subject }.to change(Identity, :count).from(1).to(0)
    end
  end
end
