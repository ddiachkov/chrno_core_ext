# encoding: utf-8
$:.push File.expand_path( "../lib", __FILE__ )
require "core_ext/version"

Gem::Specification.new do |s|
  s.name        = "chrno_core_ext"
  s.version     = CoreExt::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = [ "Denis Diachkov" ]
  s.email       = [ "d.diachkov@gmail.com" ]
  s.homepage    = "http://larkit.ru"
  s.summary     = "Some extensions for core classes"

  s.files         = Dir[ "*", "lib/**/*" ]
  s.require_paths = [ "lib" ]

  s.required_ruby_version = "1.9"

  s.add_runtime_dependency "rails", ">= 3.0"
end