# encoding: utf-8
require 'active_support/core_ext/string/inflections'
require 'thor'

module Creperie
  module Generators
    class App < Thor::Group
      include Thor::Actions

      source_root File.expand_path('../templates/app', __FILE__)
      argument :app_name

      def app_name_const
        app_name.camelize
      end

      def generate
        say 'Pouring a new crêpe...'

        directory '.', app_name

        inside(app_name) do
          run 'bundle install'

          run 'git init', capture: true
          run 'git add .', capture: true
          run 'git commit -am "Initial commit"', capture: true

          say 'Your crêpe is ready.', :green
        end
      end
    end
  end
end
