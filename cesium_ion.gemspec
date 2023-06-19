$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "cesium_ion/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.version     = CesiumIon::VERSION
  s.name        = 'cesium-ion-ruby'
  s.summary     = 'Cesium Ion REST API wrapper'
  s.description = 'A gem that provides ability to implement cesium_ion rest apis in ruby.'
  s.required_ruby_version = '>= 2.5'

  s.author    = 'Rahul Singh'
  s.email     = 'rahul97811@gmail.com'
  s.homepage  = 'https://github.com/rahulsingh321/cesium-ion-ruby.git'
  s.license   = 'BSD-3-Clause'

  s.files     = `git ls-files`.split("\n").reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }

  s.add_dependency 'aws-sdk-s3', '~> 1'
end
