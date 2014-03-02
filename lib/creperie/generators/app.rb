# encoding: utf-8
require 'active_support/core_ext/string/inflections'
require 'thor'

module Creperie
  module Generators
    class App < Thor::Group
      include Thor::Actions
      add_runtime_options!
      source_root File.expand_path('../templates/app', __FILE__)

      # Use --skip-bundle to skip running `bundle install`
      class_option :skip_bundle, type: :boolean, desc: "Don't run bundle install",
                                 aliases: '-B', default: false

      # Use --skip-git to skip initializing a git repository
      class_option :skip_git, type: :boolean, desc: "Don't create a git repository",
                              aliases: '-G', default: false

      # Use --help to print more detailed USAGE information than `crepe help new` would.
      class_option :help, type: :boolean, desc: "Print this usage information and exit",
                              aliases: '-h', default: false

      argument :app_name

      desc 'Create a new Crepe application.'
      def generate
        say 'Pouring a new crêpe...'

        copy_source_tree

        inside(app_name) do
          bundle_install
          git_init
        end

        say 'Your crêpe is ready.', :green
      end

      protected

      # This will turn `app_name` into `AppName` to write constants.
      def app_name_const
        app_name.camelize
      end

      def git_init
        return if options[:skip_git]

        run 'git init', capture: true
        run 'git add .', capture: true
        run 'git commit -am "Initial commit"', capture: true
      end

      def bundle_install
        run 'bundle install' unless options[:skip_bundle]
      end

      def copy_source_tree
        directory '.', app_name
      end
    end
  end
end
