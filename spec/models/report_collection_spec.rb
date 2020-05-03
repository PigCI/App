require 'rails_helper'

RSpec.describe ReportCollection, type: :model do
  context '#conclusion!' do
    let(:report_collection) { build(:report_collection) }
    let(:project) { report_collection.project }
    subject { report_collection.conclusion! }

    context 'All netural reports' do
      it do
        expect { subject }.to change(report_collection, :conclusion).from('neutral').to('success')
      end
    end

    context 'With a failing reports' do
      before do
        report_collection.reports.first.conclusion = 'failure'
      end

      it do
        expect { subject }.to change(report_collection, :conclusion).from('neutral').to('failure')
      end
    end
  end
end
