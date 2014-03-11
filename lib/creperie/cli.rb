require 'clamp'
require 'creperie/commands'
require 'creperie/loader'

module Creperie
  class CLI < Commands::Base
    def execute
      request_help
    end

    subcommand 'new', 'Generate a new Crêpe application.', Commands::New

    if Loader.crepe_app?
      subcommand ['console', 'c'], 'Start the Crêpe console.', Commands::Console
      subcommand ['server',  's'], 'Start the Crêpe server.',  Commands::Server
    end
  end
end
