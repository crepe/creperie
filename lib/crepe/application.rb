require 'crepe/application/configuration'

module Crepe
  class << self
    attr_accessor :application
  end

  # Provides a singleton-esque accessor to a Crepe application and houses
  # configuration for an application.
  class Application
    class << self
      attr_reader :config

      def inherited(base)
        base.instance_variable_set(:@config, Configuration.new)
        base.instance_variable_set(:@app, Class.new(Crepe::API))

        # Assign Crepe.application if it doesn't exist
        Crepe.application ||= base
      end

      def configure(&block)
        if block.arity == 1
          yield config
        else
          config.instance_eval(&block)
        end
      end

      def initialize!
        load_environment!
        run_initializers!
        load_routes!
      end

      def call(env)
        @app.call(env)
      end

      def routes(&block)
        @app.instance_eval(&block)
      end

      def load_seed
        seed_file = Crepe.root.join('db', 'seeds')
        load seed_file if File.exists?(seed_file)
      end

      private

      def load_environment!
        require Crepe.root.join('config', 'environments', Crepe.env)
      end

      def run_initializers!
        initializers = Crepe.root.join('config', 'initializers', '*.rb')
        Dir[initializers].sort.each { |initializer| require initializer }
      end

      def load_routes!
        require Crepe.root.join('config', 'routes')
      end
    end
  end
end
