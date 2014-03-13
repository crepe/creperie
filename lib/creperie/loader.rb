require 'pathname'

module Creperie
  module Loader
    class << self
      # If we find a Gemfile using the method below and it contains Crepe
      # as a dependency, we can safely assume we're in a Crepe application.
      def crepe_app?
        File.read(find_file(gemfile)) =~ /gem (['"])crepe\1/
      end

      def application
        return unless crepe_app?
        fild_file('./config/application.rb')
      end

      def config_ru
        return unless crepe_app?
        find_file('config.ru')
      end

      def gemfile
        find_file('Gemfile')
      end

      def gemfile_lock
        find_file('Gemfile.lock')
      end

      private

      def find_file(filename)
        original_dir = Dir.pwd

        loop do
          # Return the full path of the file if we find it.
          return File.expand_path(filename) if File.file?(filename)

          # If we've reached the root of the filesystem without finding the
          # specified file, give up.
          Dir.chdir(original_dir) and return if Pathname.new(Dir.pwd).root?

          # Otherwise, move up a directory and search again.
          Dir.chdir('..')
        end
      end
    end
  end
end
