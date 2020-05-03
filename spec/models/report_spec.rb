require 'rails_helper'

RSpec.describe Report, type: :model do
  describe '#calc_max_difference_from_default_branch' do
    subject { report.calc_max_difference_from_default_branch }

    let(:report) { Report.new(max: 100) }
    let(:previous_report_from_default_branch) { double(:report, max: 100) }

    before do
      allow(report).to receive(:previous_report_from_default_branch).and_return(previous_report_from_default_branch)
    end

    it { is_expected.to eq(0) }

    context 'new report is lower' do
      let(:report) { Report.new(max: 50) }
      it { is_expected.to eq(BigDecimal(-50)) }
    end

    context 'new report is higher' do
      let(:report) { Report.new(max: 150) }
      it { is_expected.to eq(BigDecimal(50)) }
    end

    context 'previous report is zero' do
      let(:previous_report_from_default_branch) { double(:report, max: 0) }
      it { is_expected.to eq(BigDecimal(0)) }
    end

    context 'current report is zero' do
      let(:report) { Report.new(max: 0) }
      it { is_expected.to eq(BigDecimal(0)) }
    end

    context 'current report is minus number, and previous report is zero' do
      let(:report) { Report.new(max: -100) }
      let(:previous_report_from_default_branch) { double(:report, max: 0) }
      it { is_expected.to eq(BigDecimal(0)) }
    end
  end

  describe '#calc_min_difference_from_default_branch' do
    subject { report.calc_min_difference_from_default_branch }

    let(:report) { Report.new(min: 100) }
    let(:previous_report_from_default_branch) { double(:report, min: 100) }

    before do
      allow(report).to receive(:previous_report_from_default_branch).and_return(previous_report_from_default_branch)
    end

    it { is_expected.to eq(0) }

    context 'new report is lower' do
      let(:report) { Report.new(min: 50) }
      it { is_expected.to eq(BigDecimal(-50)) }
    end

    context 'new report is higher' do
      let(:report) { Report.new(min: 150) }
      it { is_expected.to eq(BigDecimal(50)) }
    end

    context 'previous report is zero' do
      let(:previous_report_from_default_branch) { double(:report, min: 0) }
      it { is_expected.to eq(BigDecimal(0)) }
    end

    context 'current report is zero' do
      let(:report) { Report.new(min: 0) }
      it { is_expected.to eq(BigDecimal(0)) }
    end

    context 'current report is minus number, and previous report is zero' do
      let(:report) { Report.new(min: -100) }
      let(:previous_report_from_default_branch) { double(:report, min: 0) }
      it { is_expected.to eq(BigDecimal(0)) }
    end
  end
end
