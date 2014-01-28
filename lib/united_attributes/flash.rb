require_relative 'missing_key_error'

module UnitedAttributes
  class Flash # Portmanteau of Flattened Hash

    attr_reader :data

    def initialize(hsh)
      @data = hsh
    end

    def l(key = '')
      segments = key.split('.')
      current_node = segments.any? ? data[segments.shift] : data
      segments.each do |segment|
        current_node = current_node.is_a?(Hash) ? current_node[segment] : nil
      end
      current_node
    end

    def l!(key)
      l(key) || (raise MissingKeyError)
    end

  end
end
