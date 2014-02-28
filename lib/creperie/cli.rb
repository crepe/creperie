require 'creperie/version'
require 'thor'

module Creperie
  class CLI < Thor
    desc :version, 'Display the Creperie version'
    def version
      say "Creperie #{Creperie::VERSION}"
      begin
        require 'crepe'
        say "Crepe #{Crepe::VERSION}"
      rescue LoadError
      end
    end
  end
end
