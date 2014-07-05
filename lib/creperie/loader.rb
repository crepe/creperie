require 'pathname'

module Creperie
  # This module is responsible for behavior related to loading a Crêpe
  # application.
  module Loader
    class << self
      # If we find a Gemfile using the method below and it contains Crepe
      # as a dependency, we can safely assume we're in a Crepe application.
      def crepe_app?
        return unless gemfile
        File.read(gemfile) =~ /gem (['"])crepe\1/
      end

      def config_ru
        return unless crepe_app?
        find_file('config.ru')
      end

      def gemfile
        find_file('Gemfile')
      end

      private

      def find_file(filename)
        original_dir = Dir.pwd

        loop do
          # Return the full path of the file if we find it.
          return File.expand_path(filename) if File.file?(filename)

          # If we've reached the root of the filesystem without finding the
          # specified file, give up.
          return if Pathname.new(Dir.pwd).root?

          # Otherwise, move up a directory and search again.
          Dir.chdir('..')
        end
      ensure
        Dir.chdir(original_dir)
      end
    end
  end
end
