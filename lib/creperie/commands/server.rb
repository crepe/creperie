require 'creperie/commands/base'
require 'creperie/loader'

module Creperie
  module Commands
    class Server < Base
      option ['-s', '--server'], 'SERVER', 'Serve using the specified dispatcher'

      option ['-o', '--host'], 'HOST', 'Binds Crêpe to the specified host', default: '0.0.0.0'
      option ['-p', '--port'], 'PORT', 'Runs Crêpe on the specified port', default: 9292 do |o|
        Integer(o)
      end
      option ['-E', '--env'], 'ENV', 'Specify the Crêpe environment', default: 'development'
      option ['-P', '--pid'], 'PIDFILE', "Store Crêpe's PID in the specified file"
      option ['-c', '--config'], 'RACKUP_FILE', 'Specify a Rackup file other than config.ru'
      option ['-D', '--daemonize'], :flag, 'Run Crêpe daemonized in the background'

      def execute
        rackup  = "bundle exec rackup"
        rackup += " -s #{server}" if server
        rackup += " -p #{port}"   if port
        rackup += " -o #{host}"   if host
        rackup += " -E #{env}"    if env
        rackup += " -P #{pid}"    if pid
        rackup += " -D"           if daemonize?

        # By default, find the project's config.ru file and use it.
        config = config || Loader.config_ru
        rackup += " #{config}"

        Kernel.exec(rackup)
      end
    end
  end
end
