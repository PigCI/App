require 'rails_helper'

describe 'Billings', type: :request do
  let(:user) { create(:user, :with_install) }
  before { sign_in user }
  
  describe 'GET /billing' do
    subject { get billing_path }

    it { expect{ subject }.to_not raise_error }
  end
end
