require 'rails_helper'

FactoryBot.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
    it { expect(build(factory_name)).to be_valid }
    it { expect(create(factory_name).persisted?).to eq(true) }

    FactoryBot.factories[factory_name].defined_traits.each do |trait|
      context "trait: #{trait}" do
        it { expect(build(factory_name, trait.name)).to be_valid }
        it { expect(create(factory_name, trait.name).persisted?).to eq(true) }
      end
    end
  end
end
