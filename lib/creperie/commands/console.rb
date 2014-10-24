require 'creperie/commands/base'
require 'creperie/loader'
require 'rack/console'

module Creperie
  module Commands
    # Uses Rack::Console to start a `rails console` analogue for Crepe.
    class Console < Base
      option ['-c', '--config'],  'RACKUP_FILE',
                                  'Specify a Rackup file other than config.ru'
      option ['-I', '--include'], 'PATHS',
                                  'Add paths (colon-separated) to $LOAD_PATH',
                                  attribute_name: '_include'
      option ['-r', '--require'], 'LIBRARY',
                                  'Require a file or library before Crepe runs',
                                  attribute_name: '_require'

      parameter '[ENVIRONMENT]', 'Specify the Crepe environment',
                                 default: 'development'

      def execute
        require 'crepe/version'

        loading = "Loading #{environment} environment"
        version = "(Crepe #{Crepe::VERSION})"
        ENV['RACK_CONSOLE_PREAMBLE'] = "#{loading} #{version}"

        Rack::Console.start(options)
      end

      private

      def options
        {}.tap do |options|
          options[:environment] = environment
          options[:require]     = _require    if _require
          options[:include]     = _include    if _include
          options[:config]      = config      || Loader.config_ru
        end
      end
    end
  end
end
