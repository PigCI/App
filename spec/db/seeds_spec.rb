require 'rails_helper'

RSpec.describe 'Seeds' do
  context 'Rails.application.load_seed' do
    subject { Rails.application.load_seed }

    it do
      expect { subject }.to change(Install, :count).by(1)
        .and change(User, :count).by(1)
        .and change(GithubRepository, :count).by(1)
        .and change(Project, :count).by(1)
        .and change(ReportCollection, :count).by(21)
        .and change(Report, :count).by(63)
    end
  end
end
