require 'creperie/commands/base'
require 'creperie/loader'

module Creperie
  module Commands
    class Console < Base
      option ['-E', '--env'], 'ENV', 'Specify the Crêpe environment', default: 'development' do |env|
        ENV['CREPE_ENV'] = env
      end

      def execute
        Rack::Builder.parse_file(Loader.config_ru)

        begin
          require 'pry'
          Pry.start
        rescue LoadError
          IRB.start
        end
      end
    end
  end
end
