require 'forwardable'
require_relative 'localizer'

class UnitedAttributes::Attribute
  attr_accessor :options, :domain
  extend Forwardable
  def_delegators(:to_s, :upcase, :gsub)

  def initialize(value, options)
    @options = options
    @value = value
    self.domain = options[:domain]
  end

  def available_units
    UnitedAttributes::Domains.query(domain).keys
  end

  def unit
    @options[:unit]
  end

  def domain
    @options[:domain]
  end

  def to_s
    [("%.#{precision}f" % @value), localizer.t("#{domain}.#{unit}.other")].join(" ")
  end

  def precision(precision = nil)
    return @options[:precision] if precision.nil?
    new(value, @options.merge(precision: precision))
  end

  def value
    @value
  end

  def domain_units
    r = UnitedAttributes::Domains.query(domain)
    puts r
    r
  end

  def as(unit)
    unit = unit.to_s
    UnitedAttributes::Attribute.new(convert(unit), @options.merge(unit: unit))
  end

  private

  def localizer
    UnitedAttributes::Localizer.default
  end

  def convert(to)
    current_factor = domain_units[unit]
    new_factor = domain_units[to]
    (value.to_f * current_factor ) / new_factor
  end



end
