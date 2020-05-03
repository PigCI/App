require 'rails_helper'

describe 'Webhooks - Github - Organization - member removed', type: :request do
  let(:headers) do
    {
      CONTENT_TYPE: 'application/json',
      HTTP_X_GITHUB_EVENT: 'organization'
    }
  end

  let(:user) { create(:user, :with_identity, :with_install) }
  let(:install) { user.installs.first }
  let(:identity) { user.identities.first }

  let(:request_body) do
    JSON.parse(Rails.root.join('spec', 'fixtures', 'files', 'webhooks', 'github', 'organization', 'member_removed.json').read).tap do |json|
      json['installation']['id'] = install.install_id
      json['membership']['user']['id'] = identity.uid
    end.to_json
  end

  subject do
    post webhooks_github_index_url(subdomain: :webhooks), params: request_body, headers: headers
  end

  it 'Removes the user from the install' do
    expect { subject }.to change { install.users.where(id: user.id).count }.from(1).to(0)
  end
end
