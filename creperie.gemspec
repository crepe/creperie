# encoding: utf-8
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'creperie/version'

Gem::Specification.new do |gem|
  gem.name          = 'creperie'
  gem.version       = Creperie::VERSION
  gem.authors       = ['David Celis']
  gem.email         = ['me@davidcel.is']
  gem.summary       = 'Pour a new Crêpe app.'
  gem.description   = 'Create and maintain your Crêpe applications.'
  gem.homepage      = 'https://github.com/davidcelis/creperie'
  gem.license       = 'MIT'

  gem.executables   = ['crepe']
  gem.files         = Dir['lib/**/{*,.*}']
  gem.test_files    = Dir['spec/**/*']
  gem.require_paths = ['lib']

  gem.add_dependency 'clamp', '~> 0.6'
  gem.add_dependency 'thor', '~> 0.19'

  gem.add_development_dependency 'rspec', '~> 3.0'
end
