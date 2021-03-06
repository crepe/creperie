# encoding: utf-8
require 'thor/group'
require 'thor/actions'

module Creperie
  module Generators
    # Generate a new Crepe application.
    class App < Thor::Group
      include Thor::Actions
      add_runtime_options!
      source_root File.expand_path('../templates/app', __FILE__)

      class_option :skip_bundle, type: :boolean,
                                 desc: "Don't run bundle install",
                                 aliases: '-B',
                                 default: false

      class_option :skip_git,    type: :boolean,
                                 desc: "Don't create a git repository",
                                 aliases: '-G',
                                 default: false

      argument :name

      def copy_files
        say 'Pouring a new Crepe...'

        directory '.', name
      end

      def bundle_install
        return if options[:skip_bundle]

        inside(name) { run 'bundle install' }
      end

      def git_init
        return if options[:skip_git]

        inside(name) do
          run 'git init', capture: true
          run 'git add .', capture: true
          run 'git commit -am "Initial commit"', capture: true
        end
      end

      def finish
        say 'Your Crepe is ready.', :green
      end

      protected

      # This will turn `app_name` into `AppName` to write constants.
      def app_name_const
        name.gsub(/\W/, '_').gsub(/[a-z\d]*/) { $&.capitalize }.gsub('_', '')
      end
    end
  end
end
