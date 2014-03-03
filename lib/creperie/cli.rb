require 'thor'
require 'creperie/loader'
require 'creperie/generators/app'

module Creperie
  class CLI < Thor
    desc :version, 'Display the Creperie version'
    def version
      require 'creperie/version'
      say "Creperie #{Creperie::VERSION}"

      begin
        require 'crepe'
        say "Crepe    #{Crepe::VERSION}"
      rescue LoadError
      end
    end

    register Generators::App, 'new', 'new [APP_NAME]', 'Create a new Crepe application.'

    if Creperie::Loader.crepe_app?
      require 'creperie/commands'

      register Commands::Server, 'server', 'server', 'Start the Crêpe server (shortcut alias: "s")'
    end
  end
end
