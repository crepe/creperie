require 'clamp'
require 'creperie/commands/new'
require 'creperie/loader'

module Creperie
  class CLI < Commands::Base
    def execute
      request_help
    end

    subcommand 'new', 'Generate a new Crêpe application.', Commands::New

    if Loader.crepe_app?
      require 'creperie/commands/console'
      subcommand ['console', 'c'], 'Start the Crêpe console.', Commands::Console

      require 'creperie/commands/server'
      subcommand ['server',  's'], 'Start the Crêpe server.',  Commands::Server
    end
  end
end
