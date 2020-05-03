# frozen_string_literal: true

require 'rails_helper'

describe 'Webhooks - Github - Repository - Renamed', type: :request do
  let(:headers) do
    {
      CONTENT_TYPE: 'application/json',
      HTTP_X_GITHUB_EVENT: 'repository'
    }
  end

  let(:project) { create(:project) }
  let(:install) { project.install }
  let(:github_repository) { project.github_repository }

  let(:request_body) do
    JSON.parse(Rails.root.join('spec', 'fixtures', 'files', 'webhooks', 'github', 'repository', 'renamed.json').read).tap do |json|
      json['installation']['id'] = install.install_id
      json['changes']['repository']['name']['from'] = github_repository.full_name
      json['repository']['id'] = github_repository.github_id
      json['repository']['name'] = 'new-name'
      json['repository']['full_name'] = 'PigCI/new-name'
    end.to_json
  end

  subject do
    post webhooks_github_index_url(subdomain: :webhooks), params: request_body, headers: headers
  end

  it 'renames a repo and project' do
    expect { subject }.to change{ github_repository.reload.full_name }.to('PigCI/new-name')
      .and change { github_repository.reload.name }.to('new-name')
      .and change { project.reload.full_name }.to('PigCI/new-name')
      .and change { project.reload.name }.to('new-name')
  end
end

