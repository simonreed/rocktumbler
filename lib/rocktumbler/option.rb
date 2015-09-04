require 'optparse'
require 'pp'

module Rocktumbler
  class Option
    #
    # Return a structure describing the options.
    #
    def self.parse(args)
      # The options specified on the command line will be collected in *options*.
      # We set default values here.
      options = OpenStruct.new
      options.docs = true

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: example.rb [options]"

        opts.separator ""
        opts.separator "Specific options:"

        # Boolean switch.
        opts.on("-d", "--no-documentation", "Don't display gem documentation") do |docs|
          options.docs = false
        end

        opts.on("-s", "--skip-write", "Skip writing of Gemfile") do |docs|
          options.docs = false
        end

        opts.separator ""
        opts.separator "Common options:"

        # No argument, shows at tail.  This will print an options summary.
        # Try it and see!
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        # Another typical switch to print the version.
        opts.on_tail("--version", "Show version") do
          puts Rocktumbler::Version.join('.')
          exit
        end
      end

      opt_parser.parse!(args)
      options
    end
  end
end
