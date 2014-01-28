require_relative '../lib/united_attributes'
require_relative 'dummy_model'

describe UnitedAttributes::Model do

  let(:model) { DummyModel.new }

  it 'should work' do
    model.united_age.as(:hour).to_s.should eql "72 hours"
  end

  it 'should support switching locales' do
    UnitedAttributes::Localizer.default.locale = :da
    model.united_age.as(:hour).to_s.should eql "72 timer"
  end

end

