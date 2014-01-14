require_relative '../lib/united_attributes/flash'

describe UnitedAttributes::Flash do

  let(:hash) do
    {
        'foo' => {
            'bar' => 'hello world',
            'baz' => 'ready'
        }
    }
  end

  let(:flash) { UnitedAttributes::Flash.new(hash) }

  it 'returns the correct value for a valid key' do
    flash.l('foo.baz').should eql 'ready'
  end

  it 'returns nil for an invalid key' do
    flash.l('foo.bar.baz').should be_nil
  end

  it 'returns the subhash for "incomplete" keys' do
    flash.l('foo').should eql({'bar' => 'hello world', 'baz' => 'ready'})
  end


  context 'l!' do

    it 'raises an exception' do
      expect{ flash.l!('imaginary.key') }.to raise_error UnitedAttributes::MissingKeyError
    end

  end

end
