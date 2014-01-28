require_relative '../lib/united_attributes/localizer'

describe UnitedAttributes::Localizer do

  let(:localizer) { UnitedAttributes::Localizer.new }

  it 'supports changing locale' do
    localizer.locale = :da
    localizer.locale.should eql :da
  end

  it 'uses English as default locale' do
    localizer.locale.should eql :en
  end

end


