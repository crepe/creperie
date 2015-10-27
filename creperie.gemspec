# encoding: utf-8
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'creperie/version'

Gem::Specification.new do |s|
  s.name          = 'creperie'
  s.version       = Creperie::VERSION
  s.authors       = ['David Celis']
  s.email         = ['me@davidcel.is']
  s.summary       = 'Pour a new Crepe app.'
  s.description   = 'Create and maintain your Crepe applications.'
  s.homepage      = 'https://github.com/davidcelis/creperie'
  s.license       = 'MIT'

  s.executables   = ['crepe']
  s.files         = Dir['lib/**/{*,.*}']
  s.test_files    = Dir['spec/**/*']
  s.require_paths = ['lib']

  s.has_rdoc = 'yard'

  s.required_ruby_version = '>= 2.1.0'

  s.add_dependency 'crepe', '~> 0.0.1.pre'
  s.add_dependency 'clamp', '~> 1.0.x'
  s.add_dependency 'thor', '~> 0.19.x'
  s.add_dependency 'rack-console', '~> 1.3.x'
  s.add_dependency 'listen', '~> 3.0.x'

  s.add_development_dependency 'rspec', '~> 3.3.x'
  s.add_development_dependency 'fakefs', '~> 0.6.x'
  s.add_development_dependency 'cane', '~> 2.6.x'
  s.add_development_dependency 'rake', '~> 10.4.x'
  s.add_development_dependency 'yard', '~> 0.8.x'
end
