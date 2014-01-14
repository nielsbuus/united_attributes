require 'singleton'
require 'yaml'
require_relative 'flash'

module UnitedAttributes
  class Localizer

    class << self

      def default
        @@default ||= new
      end

    end

    attr_accessor :locale, :flash

    def initialize
      @locale = :en

      this_dir = File.dirname(__FILE__)
      path = File.join(this_dir, 'locales', '*.yml')
      root_hsh = {}
      Dir.glob(path).each do |full_path|
        root_hsh[File.basename(full_path, '.yml')] = YAML.load(File.read(full_path))
      end
      @flash = Flash.new(root_hsh)
    end

    def t(key)
      flash.l("#{locale}.#{key}")
    end

  end
end
