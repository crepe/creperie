module Creperie
  module Commands
    class Server < Thor::Group
      class_option :server, desc: 'Serve using the specified dispatcher',
                             type: :string, aliases: '-s'
      class_option :port, desc: 'Runs Crêpe on the specified port',
                           type: :numeric, aliases: '-p', default: 9292
      class_option :host, desc: 'Binds Crêpe to the specified host',
                           type: :string, aliases: '-o', default: '0.0.0.0'
      class_option :env, desc: 'Specify the Crêpe environment',
                          type: :string, aliases: '-E', default: 'development'
      class_option :daemonize, desc: 'Run Crêpe daemonized in the background',
                                type: :boolean, aliases: '-D', default: false
      class_option :pid, desc: "Store Crêpe's PID in the specified file",
                          type: :string, aliases: '-P'
      class_option :config, desc: 'Specify a Rackup file other than config.ru',
                             type: :string, aliases: '-c'
      class_option :help, desc: 'Print this usage information and exit',
                           type: :boolean, aliases: '-h', default: false

      desc 'Start the Crêpe server (alias shortcut: "s")'
      def server
        rackup_cmd  = "bundle exec rackup"
        rackup_cmd += " -p #{options[:port]}"
        rackup_cmd += " -o #{options[:host]}"
        rackup_cmd += " -E #{options[:env]}"
        rackup_cmd += " -D" if options[:daemonize]
        rackup_cmd += " -P #{options[:pid]}" if options[:pid]
        rackup_cmd += " #{options[:config]}" if options[:config]

        Kernel.exec(rackup_cmd)
      end
    end
  end
end
