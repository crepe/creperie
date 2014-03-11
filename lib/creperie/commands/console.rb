require 'creperie/commands/base'
require 'creperie/loader'

module Creperie
  module Commands
    class Console < Base
      option ['-E', '--env'], 'ENV', 'Specify the Crêpe environment', default: 'development' do |env|
        ENV['CREPE_ENV'] = env
      end

      def execute
        with_rack_aliased! do
          load Loader.config_ru
        end

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

      # The best way to load a Crêpe application's environment into an IRB shell
      # is to load the config.ru file, as that must load/require all code
      # necessary to run the application. However, this means we must provide
      # two DSL methods expected to be mixed into Object by Rack::Builder, `use`
      # and `run`. To prevent the permanence from this, we load config.ru with
      # those methods defined as no-ops and then undefine them afterwards.
      def with_rack_aliased!(&block)
        alias_rack!
        yield
        unalias_rack!
      end

      def alias_rack!
        Object.class_eval do
          def use(*args) end
          def run(*args) end
        end
      end

      def unalias_rack!
        Object.class_eval do
          undef :use
          undef :run
        end
      end
    end
  end
end
