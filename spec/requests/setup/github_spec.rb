require 'rails_helper'

describe 'Setup - Github', type: :request do
  let(:user) { create(:user, :with_install) }
  
  describe 'GET /setup/github?installation_id=1096191&setup_action=update' do
    subject { get setup_github_path(installation_id: '1096191', setup_action: :update) }

    context 'without a signed in user' do
      it do
        subject
        expect(response).to redirect_to(user_github_omniauth_authorize_path)
      end
    end

    context 'with a signed in user' do
      before { sign_in user }

      it { expect{ subject }.to_not raise_error }
    end
  end
end
