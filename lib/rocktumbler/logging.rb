module Rocktumbler
  module Logging

    LOG_LEVELS = {
      :fatal  => 4,
      :error  => 3,
      :warn   => 2,
      :info   => 1,
      :debug  => 0
    }

    LOG_LEVELS.each do |level, value|
      define_method(level) { |*args| write_log(args, level) }
    end

  private

    def write_log(message, level)
      return unless Rocktumbler.logger

      banner = "[#{ self.class.name }] "

      if Rocktumbler.logger.respond_to?(level)
        Rocktumbler.logger.__send__(level, banner + message)
      elsif Rocktumbler.logger.respond_to?(:call)
        Rocktumbler.logger.call(banner + message)
      end
    end

  end
end
