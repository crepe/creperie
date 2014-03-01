require 'creperie/generators/app'

require 'thor'

module Creperie
  class CLI < Thor
    desc :version, 'Display the Creperie version'
    def version
      require 'creperie/version'
      say "Creperie #{Creperie::VERSION}"

      begin
        require 'crepe'
        say "Crepe #{Crepe::VERSION}"
      rescue LoadError
      end
    end

    register Generators::App, 'new', 'new [APP_NAME]', 'Create a new Crepe application'
  end
end
