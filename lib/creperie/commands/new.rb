require 'creperie/commands/base'
require 'creperie/generators/app'

module Creperie
  module Commands
    # This command exists in addition to the App generator because of how Thor
    # handles help invocation. `crepe help new` and `crepe new --help` would
    # annoyingly generate different USAGE banners, so this Clamp command exists
    # to proxy options and arguments to it instead.
    class New < Base
      parameter 'APP_PATH', 'The name and path of your Crêpe application'

      # Generator options
      option ['-B', '--skip-bundle'], :flag, "Don't run bundle install."
      option ['-G', '--skip-git'],    :flag, "Don't create a git repository."

      # Runtime options
      option ['-f', '--force'],   :flag, 'Overwrite files that already exist.'
      option ['-p', '--pretend'], :flag, 'Run but do not make any changes'
      option ['-q', '--quiet'],   :flag, 'Suppress status output'
      option ['-s', '--skip'],    :flag, 'Skip files that already exist'

      def execute
        options = parse_options.reduce({}) do |h, option|
          h.tap { |h| h[option.attribute_name] = send(option.read_method) }
        end

        Generators::App.new([app_path], options).invoke_all
      end
    end
  end
end
