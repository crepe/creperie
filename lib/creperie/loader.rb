require 'pathname'

module Creperie
  module Loader
    EXECUTABLE = 'bin/crepe'
    def self.crepe_app?
      original_dir = Dir.pwd

      loop do
        # To detect whether or not we're in a Crepe application, we search
        # recursively through parent directories for a Gemfile that declares
        # a dependency on Crepe.
        if File.file?('config.ru')
          return true if File.read('Gemfile') =~ /gem (['"])crepe\1/
        end

        # If we've reached the root of the filesystem without finding a
        # Gemfile with Crepe, give up and only provide the `crepe new` command.
        Dir.chdir(original_dir) and return if Pathname.new(Dir.pwd).root?

        # Otherwise, move up a directory and search again.
        Dir.chdir('..')
      end
    end
  end
end
