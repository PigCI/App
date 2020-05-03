require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Defaults' do
    subject { user.save! }

    describe '#name' do
      let(:user){ build(:user, name: nil) }

      it do
        expect { subject }.to change(user, :persisted?).from(false).to(true)
      end
    end
  end
end
