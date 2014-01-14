require 'yaml'
require_relative 'flash'

module UnitedAttributes
  class Domains

    class << self

      def init
        this_dir = File.dirname(__FILE__)
        @@domains = Flash.new(YAML.load(File.read(File.join(this_dir, 'domains.yml'))))
      end

      def domain_data
        @@domains ||= init
      end

      def query(domain)
        domain_data.l(domain)
      end

      def all_units
        domain_data.l
      end

    end

  end
end
