require File.expand_path('../boot', __FILE__)
require 'crepe'

# Require the gems listed in Gemfile, including any gems you've limited to
# :test, :development, or :production.
Bundler.require(:default, Crepe.env)
$LOAD_PATH.unshift Crepe.root unless $LOAD_PATH.include?(Crepe.root)

# Load initializers.
Dir['config/initializers/*'].each { |f| require f }

# Edit config/routes.rb to define routes or mount your other APIs.
require Crepe.root.join('config', 'routes')