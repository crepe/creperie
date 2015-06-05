require 'ostruct'
require 'crepe'

module Crepe
  class Application
    # Dynamic configuration with syntactic sugar for Crepe applications.
    #
    # Crepe.application.configure do
    #   config.launched_at = Time.now
    #
    #   config.mail.host = 'smtp.maildrill.com'
    #
    #   config.uptime = -> { Time.now - Crepe.application.config.launched_at }
    # end
    #
    # Crepe.application.config.mail.host
    #   #=> 'smtp.maildrill.com'
    # Crepe.application.config.launched_at?
    #   #=> true
    # Crepe.application.config.uptime
    #   #=> 2.837464
    class Configuration
      def initialize
        @config = OpenStruct.new(logger: Crepe.logger)
      end

      def respond_to_missing?(key, include_private = false)
        @config.respond_to?(key.to_s.chomp('?'), include_private) || super
      end

      def inspect
        @config.inspect.sub(@config.class.name, self.class.name)
      end

      private

      def method_missing(key, *args, &block)
        if (key = key.to_s).end_with?('=')
          @config.send(key, args.first)
        else
          boolean = key.chomp!('?')

          @config.respond_to?(key) or
            logger.warn "warning: undefined setting `#{key}' for #{inspect}"

          value   = @config[key]
          value   = value.call(*args, &block) if value.respond_to?(:call)

          boolean ? !!value : value
        end
      end
    end
  end
end
