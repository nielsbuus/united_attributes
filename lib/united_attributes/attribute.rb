require 'forwardable'

class UnitedAttributes::Attribute
  extend Forwardable
  def_delegators(:to_s, :upcase, :gsub)

  def initialize(value, options)
    @options = options
    @value = value
    UnitedAttributes::DOMAINS[@options[:domain]].keys.each do |key|
      instance_eval do
        define_singleton_method "as_#{key}s" do
          as(key)
        end
      end
    end
  end

  def unit
    @options[:unit]
  end

  def domain
    @options[:domain]
  end

  def to_s
    ("%.#{precision}f" % @value) + " " + I18n.t("united_attributes.#{domain}.#{unit}", count: @value)
  end

  def precision(precision = nil)
    return @options[:precision] if precision.nil?
    UnitedAttributes::Attribute.new(value, @options.merge(precision: precision))
  end

  def value
    @value
  end

  def domain_units
    UnitedAttributes::DOMAINS[@options[:domain]]
  end

  private

  def convert(to)
    current_factor = domain_units[unit]
    new_factor = domain_units[to]
    (value.to_f * current_factor ) / new_factor
  end

  def as(unit)
    UnitedAttributes::Attribute.new(convert(unit), @options.merge(unit: unit))
  end

end