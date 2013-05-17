module UnitedAttributes
  module Model

    # Should be called like:
    # unite :attribute, :unit, {options}
    # e.g.
    # unite :duration, :minute, domain: :time, precision: 2,

    def unite(accessor, unit, options = {})

      options.reverse_merge!({precision: 0})
      options[:unit] = unit

      unless options.has_key?(:domain)
        UnitedAttributes::DOMAINS.each do |key, value|
          if value.has_key? unit
            options[:domain] = key
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