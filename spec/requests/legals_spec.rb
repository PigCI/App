require 'rails_helper'

describe 'Legals', type: :request do
  routes_for_controller('legals').each do |route|
    describe "#{route.verb} #{route.path.spec.to_s}" do
      subject { get send("#{route.name}_path") }

      it { expect{ subject }.to_not raise_error }
    end
  end
end
