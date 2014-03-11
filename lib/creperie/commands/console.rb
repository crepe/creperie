require 'creperie/commands/base'
require 'creperie/loader'

module Creperie
  module Commands
    class Console < Base
      option ['-E', '--env'], 'ENV', 'Specify the Crêpe environment', default: 'development'

      def execute
        # The best way to load a Crêpe application's environment is to
        # find the project's config.ru file and load it, since a rackup file is
        # required to exist and should load/require all necessary files to run
        # the application. However, this means we must override Rack::Builder's
        # DSL methods, namely `use` and `run`. Because these get mixed into
        # Object, we must override those directly.
        Object.class_eval do
          def use(*args) end
          def run(*args) end
        end

        ENV['CREPE_ENV'] = env
        load Loader.config_ru

        begin
          require 'pry'
          Pry.start
        rescue LoadError
          IRB.start
        end
      end

      private

      def pry?
        gemfile = Loader.gemfile
        File.read(gemfile) =~ /gem (['"])pry/
      end
    end
  end
end
