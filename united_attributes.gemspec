$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "united_attributes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "United Attributes"
  s.version     = UnitedAttributes::VERSION
  s.authors     = ["Niels Buus"]
  s.email       = ["nielsbuus@gmail.com"]
  s.homepage    = "https://github.com/nielsbuus/united_attributes"
  s.summary     = "Declare the units of numerical model attributes."
  s.description = "TODO: Description of United Attributes."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_development_dependency "rspec", "~> 2.1"
end
