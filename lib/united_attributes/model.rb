module UnitedAttributes
  module Model

    def self.included target
      target.extend ClassMethods
    end

    # Should be called like:
    # unite :attribute, :unit, {options}
    # e.g.
    # unite :duration, :minute, domain: :time, precision: 2,

    module ClassMethods

      def unite(accessor, unit, options = {})

        options.merge!({precision: 0})
        options[:unit] = unit.to_s

        if options[:domain].nil?
          Domains.all_units.each do |domain, domain_units|
            if domain_units.has_key? unit.to_s
              options[:domain] = domain
              break
            end
          end
        end

        class_eval do
          define_method "united_#{accessor}" do
            Attribute.new(self.send(accessor), options)
          end
        end

      end

    end

  end
end
