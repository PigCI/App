require 'rails_helper'

describe 'Settings', type: :request do
  let(:user) { create(:user, :with_install) }
  before { sign_in user }
  
  describe 'GET /settings' do
    subject { get settings_path }

    it { expect{ subject }.to_not raise_error }
  end
end
