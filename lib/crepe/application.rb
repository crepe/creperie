require 'crepe/application/configuration'

module Crepe
  # Provides a singleton-esque accessor to a Crepe application and houses
  # configuration for an application.
  class Application
    attr_reader :config

    def initialize
      @config = Configuration.new

      # Support multiple Crepe applications like Rails, but by default set
      # Crepe.application to be the first application initialized.
      Crepe.application ||= self

      @app = Class.new(Crepe::API)
    end

    def configure(&block)
      if block.arity == 1
        yield config
      else
        instance_eval(&block)
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
      Dir[initializers].each { |initializer| require initializer }
    end

    def load_routes!
      require Crepe.root.join('config', 'routes')
    end
  end

  class << self
    def application
      @application ||= Crepe::Application.new
    end

    def application=(app)
      @application = app
    end
  end
end
