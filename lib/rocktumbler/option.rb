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
      options.gem_info = false
      options.gem_homepage = false
      options.skip_write = false
      options.verbose = false

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: tumble [options]"

        opts.separator ""
        opts.separator "Specific options:"

        opts.on("-i", "--info", "Display gem info comment.") do |docs|
          options.gem_info = true
        end

        opts.on("-d", "--homepage", "Display gem homepage comment.") do |docs|
          options.gem_homepage = true
        end

        opts.on("-s", "--skip-write", "Skip writing of Gemfile") do |docs|
          options.skip_write = true
        end

        opts.on("-l", "--verbose", "Display formatted output to STDOUT") do |docs|
          options.verbose = true
        end

        opts.separator ""
        opts.separator "Common options:"

        # No argument, shows at tail.  This will print an options summary.
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        opts.on_tail("--version", "Show version") do
          puts Rocktumbler::VERSION
          exit
        end
      end

      opt_parser.parse!(args)
      options
    end
  end
end
