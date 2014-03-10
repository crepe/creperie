require 'creperie/commands/base'
require 'creperie/loader'

module Creperie
  module Commands
    class Server < Base
      option ['-s', '--server'], 'SERVER', 'Serve using the specified dispatcher'

      option ['-p', '--port'], 'PORT', 'Runs Crêpe on the specified port', default: 9292 do |o|
        Integer(o)
      end

      option ['-o', '--host'], 'HOST', 'Binds Crêpe to the specified host', default: '0.0.0.0'
      option ['-E', '--env'], 'ENV', 'Specify the Crêpe environment', default: 'development'
      option ['-D', '--daemonize'], :flag, 'Run Crêpe daemonized in the background'
      option ['-P', '--pid'], 'PIDFILE', "Store Crêpe's PID in the specified file"
      option ['-c', '--config'], 'RACKUP_FILE', 'Specify a Rackup file other than config.ru'

      def execute
        rackup_cmd  = "bundle exec rackup"
        rackup_cmd += " -s #{server}" if server
        rackup_cmd += " -p #{port}"   if port
        rackup_cmd += " -o #{host}"   if host
        rackup_cmd += " -E #{env}"    if env
        rackup_cmd += " -P #{pid}"    if pid
        rackup_cmd += " -D"           if daemonize?

        # By default, find the project's config.ru file and use it.
        config = config || Loader.config_ru
        rackup_cmd += " #{config}"

        Kernel.exec(rackup_cmd)
      end
    end
  end
end
