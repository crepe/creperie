require 'pathname'

module Creperie
  module Loader
    class << self
      # If we find a Gemfile using the method below and it contains Crepe
      # as a dependency, we can safely assume we're in a Crepe application.
      def crepe_app?
        gemfile =~ /gem (['"])crepe\1/
      end

      def application
        return unless crepe_app?
        fild_file('./config/application.rb')
      end

      # Beginning with the current working directory, recursively search
      # up through the filesystem for a Gemfile.
      def gemfile
        find_file('Gemfile')
      end

      # Beginning with the current working directory, recursively search
      # up through the filesystem for a Gemfile.lock.
      def gemfile_lock
        find_file('Gemfile.lock')
      end

      private

      def find_file(filename)
        original_dir = Dir.pwd

        loop do
          # For convenience, return the contents of the file if we find it.
          return File.read(filename) if File.file?(filename)

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
