module UnitedAttributes
  class Railtie < Rails::Railtie
    initializer 'united_attributes.initialize' do |app|

      domains_path = File.expand_path(File.join(File.dirname(__FILE__), 'united_attributes', 'domains.yml'))
      i18n_paths = Dir.glob(File.expand_path(File.join(File.dirname(__FILE__), 'united_attributes', 'locales', '*.yml')))
      UnitedAttributes::DOMAINS = HashWithIndifferentAccess.new(YAML.load_file(domains_path))
      I18n.load_path += i18n_paths

    end
  end

end

UA = UnitedAttributes

require 'united_attributes/attribute'
require 'united_attributes/model'