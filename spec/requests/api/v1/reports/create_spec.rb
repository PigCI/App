require 'rails_helper'

describe 'API/V1 - Reports - Create', type: :request do
  let(:project) { create(:project) }
  let(:payload) do
    {
      library: 'pig-ci-app',
      library_version: '0.0.0',
      commit_sha1: 'a2ff0ad0183dae5118b6b3214536b2d695b1c865',
      head_branch: 'master',
      reports: JSON.parse(Rails.root.join('spec', 'fixtures', 'files', 'reports.json').read)
    }.to_json
  end

  subject do
    post api_v1_reports_url(subdomain: :api),
      params: payload,
      headers: { 'HTTP_X_APIKEY' => project.api_key, 'CONTENT-TYPE' => 'application/json' }
  end

  context 'with valid params' do
    it do
      expect { subject }.to change(ReportCollection, :count).by(1)
        .and change(Report, :count).by(3)
    end
  end

  context 'a report with the same commit_sha1 already exists (This is 2/2 or something)' do
    it do
      # Send the first report set
      post api_v1_reports_url(subdomain: :api), params: payload, headers: { 'HTTP_X_APIKEY' => project.api_key, 'CONTENT-TYPE' => 'application/json' }

      # Now the second set
      expect { subject }.to change(ReportCollection, :count).by(0)
        .and change(Report, :count).by(3)
    end
  end

  context 'with non JSON content type' do
    subject do
      post api_v1_reports_url(subdomain: :api),
           params: {},
           headers: { 'HTTP_X_APIKEY' => project.api_key }
    end

    it do
      subject
      expect(response).to have_http_status(422)
    end
  end

  context 'with invalid payload' do
    let(:payload) do
      {
        library: 'pig-ci-app',
        library_version: '0.0.0',
        commit_sha1: 'wrong',
        head_branch: 'wrong'
      }.to_json
    end

    it do
      subject
      expect(response).to have_http_status(422)
    end
  end

  context 'with invalid API key' do
    subject do
      post api_v1_reports_url(subdomain: :api),
        params: payload,
        headers: { 'HTTP_X_APIKEY' => 'invalid-key', 'CONTENT-TYPE' => 'application/json' }
    end

    it do
      subject
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq({
        error: 'API Key is invalid'
      }.to_json)
    end
  end
end
