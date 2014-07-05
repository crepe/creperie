require 'creperie/commands/base'
require 'creperie/loader'

module Creperie
  module Commands
    # This command will start a Rack::Server with any of the given CLI options.
    class Server < Base
      option ['-s', '--server'],    'SERVER',
                                    'Serve using the specified dispatcher'

      option ['-o', '--host'],      'HOST',
                                    'Binds Crêpe to the specified host',
                                    default: '0.0.0.0'
      option ['-p', '--port'],      'PORT',
                                    'Runs Crêpe on the specified port',
                                    default: 9292 do |o|
        Integer(o)
      end

      option ['-E', '--env'],       'ENV',
                                    'Specify the Crêpe environment',
                                    default: 'development'

      option ['-P', '--pid'],       'PIDFILE',
                                    "Store Crêpe's PID in the specified file"

      option ['-c', '--config'],    'RACKUP_FILE',
                                    'Specify a Rackup file other than config.ru'

      option ['-I', '--include'],   'PATH',
                                    "Add paths (colon-separated) to $LOAD_PATH",
                                    attribute_name: '_include' do |o|
        $LOAD_PATH.unshift(*o.split(':'))
      end

      option ['-r', '--require'],   'LIBRARY',
                                    'Require a library before Crêpe runs',
                                    attribute_name: '_require' do |o|
        require o
      end

      option ['-d', '--debug'],     :flag,
                                    'Turn on debug output ($DEBUG = true)'
      option ['-w', '--warn'],      :flag,
                                    'Turn on warnings ($-w = true)'
      option ['-D', '--daemonize'], :flag,
                                    'Run Crêpe daemonized in the background'


      def execute
        require 'bundler/setup'
        require 'rack'

        Rack::Server.start(options)
      end

      def options
        {
          config: config || Loader.config_ru,

          server: server,
          Host: host,
          Port: port,
          environment: env,
          pid: pid,
          daemonize: daemonize?,

          debug: debug?,
          warn: warn?
        }
      end
    end
  end
end
