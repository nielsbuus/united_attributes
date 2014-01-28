require_relative '../lib/united_attributes'

class DummyModel

  include UnitedAttributes::Model

  unite :age, :day

  def age
    3
  end

end
