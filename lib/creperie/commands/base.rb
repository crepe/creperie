require 'clamp'

module Creperie
  module Commands
    class Base < Clamp::Command
      option ['-v', '--version'], :flag, 'Print the Crêperie version and exit.' do
        require 'creperie/version'
        puts Creperie::VERSION
        exit 0
      end

      option ['-h', '--help'], :flag, 'Print this help message and exit.' do
        request_help
        exit 0
      end
    end
  end
end
