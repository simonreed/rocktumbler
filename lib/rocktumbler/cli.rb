require_relative 'exceptions'

module Rocktumbler
  # The CLI is a class responsible of handling all the command line interface
  # logic.
  class CLI
    attr_reader :opts

    def initialize()
      @opts = {}
    end

    def run(args = ARGV)
      @opts = Option.parse(args)
      Rocktumbler::Tumbler.new(@opts).tumble
    end
  end
end
