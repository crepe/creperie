require File.expand_path('../boot', __FILE__)
require 'crepe'

# Require the gems listed in Gemfile, including any gems you've limited to
# :test, :development, or :production.
Bundler.require(:default, Crepe.env)

# Place any environment-agnostic configuration here. This configuration object
# provides a handy accessor for any settings you may want to access across your
# application. Values can be any Ruby object and, if it is a block, it will be
# called for you dynamically when accessed.
#
# Settings in config/environments/* take precedence over those specified here.
Crepe.application.configure do
  # config.launched_at = Time.now
  # config.uptime      = -> { Time.now - Crepe.application.config.launched_at }
end

# Load initializers.
Crepe.application.initialize!
