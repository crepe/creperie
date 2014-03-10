# encoding: utf-8
require 'thor'

module Creperie
  module Generators
    class App < Thor::Group
      include Thor::Actions
      add_runtime_options!
      source_root File.expand_path('../templates/app', __FILE__)

      class_option :skip_bundle, type: :boolean, desc: "Don't run bundle install",
                                 aliases: '-B', default: false

      class_option :skip_git, type: :boolean, desc: "Don't create a git repository",
                              aliases: '-G', default: false

      argument :app_name

      def copy_files
        say 'Pouring a new crêpe...'

        directory '.', app_name
      end

      def bundle_install
        return if options[:skip_bundle]

        inside(app_name) { run 'bundle install' }
      end

      def git_init
        return if options[:skip_git]

        inside(app_name) do
          run 'git init', capture: true
          run 'git add .', capture: true
          run 'git commit -am "Initial commit"', capture: true
        end
      end

      def finish
        say 'Your crêpe is ready.', :green
      end

      protected

      # This will turn `app_name` into `AppName` to write constants.
      def app_name_const
        app_name.gsub(/[a-z\d]*/) { $&.capitalize }.gsub('_', '')
      end
    end
  end
end
