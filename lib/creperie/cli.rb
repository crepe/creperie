require 'clamp'
require 'creperie/commands/new'
require 'creperie/loader'

module Creperie
  # The command-line interface for Crepe.
  class CLI < Commands::Base
    def execute
      request_help
    end

    subcommand 'new', 'Generate a new Crepe application.', Commands::New

    if Loader.crepe_app?
      require 'creperie/commands/console'
      subcommand ['console', 'c'], 'Start the Crepe console.', Commands::Console

      require 'creperie/commands/server'
      subcommand ['server',  's'], 'Start the Crepe server.',  Commands::Server
    end
  end
end
