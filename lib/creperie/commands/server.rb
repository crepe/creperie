require 'creperie/commands/base'
require 'creperie/loader'
require 'listen'

module Creperie
  module Commands
    # This command will start a Rack::Server with any of the given CLI options.
    class Server < Base
      option ['-s', '--server'],    'SERVER',
                                    'Serve using the specified dispatcher'
      option ['-o', '--host'],      'HOST',
                                    'Binds Crepe to the specified host',
                                    default: '0.0.0.0'
      option ['-p', '--port'],      'PORT',
                                    'Runs Crepe on the specified port',
                                    default: 9292
      option ['-E', '--env'],       'ENV',
                                    'Specify the Crepe environment'
      option ['-P', '--pid'],       'PIDFILE',
                                    "Store Crepe's PID in the specified file"
      option ['-c', '--config'],    'RACKUP_FILE',
                                    'Specify a Rackup file other than config.ru'
      option ['-I', '--include'],   'PATH',
                                    'Add paths (colon-separated) to $LOAD_PATH',
                                    attribute_name: :_include
      option ['-r', '--require'],   'LIBRARY',
                                    'Require a library before Crepe runs',
                                    attribute_name: :_require
      option ['-d', '--debug'],     :flag,
                                    'Turn on debug output ($DEBUG = true)'
      option ['-w', '--warn'],      :flag,
                                    'Turn on warnings ($-w = true)'
      option ['-D', '--daemonize'], :flag,
                                    'Run Crepe daemonized in the background'


      def execute
        require 'bundler/setup'
        require 'rack'

        watch_for_changes! if options[:environment] == 'development'

        print "\033]0;crepe\007"

        ENV['RACK_ENV'] = options[:environment]
        Rack::Server.start(options)
      end

      private

      def options
        {}.tap do |opts|
          opts[:config]      = config || Loader.config_ru
          opts[:server]      = server        if server
          opts[:Host]        = host
          opts[:Port]        = Integer(port)
          opts[:environment] = env
          opts[:pid]         = pid           if pid
          opts[:daemonize]   = daemonize?
          opts[:require]     = _require      if _require
          opts[:include]     = _include      if _include
          opts[:debug]       = debug?
          opts[:warn]        = warn?
        end
      end

      def default_env
        ENV['CREPE_ENV'] || ENV['RACK_ENV'] || 'development'
      end

      def watch_for_changes!
        listener = Listen.to Dir.pwd, only: /\.(rb|ru|yml)$/ do
          puts 'Source code changes detected. Reloading...'
          Kernel.exec $0, *ARGV
        end

        listener.start
      end
    end
  end
end
