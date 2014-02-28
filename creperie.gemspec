# encoding: utf-8
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'creperie/version'

Gem::Specification.new do |gem|
  gem.name          = 'creperie'
  gem.version       = Creperie::VERSION
  gem.authors       = ["David Celis"]
  gem.email         = ["me@davidcel.is"]
  gem.summary       = %q{Pour yourself a new Crêpe app.}
  gem.description   = %q{Create and maintain your Crêpe applications.}
  gem.homepage      = 'https://github.com/davidcelis/creperie'
  gem.license       = 'MIT'

  gem.files         = Dir['lib/**/*.rb']
  gem.require_paths = ['lib']
end
