require_relative 'exceptions'

module Rocktumbler
  # The Gemfile is a class responsible for reading and parsing a Gemfile
  class Gemfile
    attr_accessor :ruby, :source

    def initialize(gemfile_location)
      @gemfile_location = gemfile_location
      @gemfile_contents = read_contents
      @ruby = parse_ruby
      @source = parse_source
    end

    def read_contents
      gemfile = File.open(@gemfile_location, 'r')
      str = gemfile.read
      gemfile.close
      str
    end

    def print_source_and_ruby
      str = ''
      str += "#{@source.tr('\"', '\'')}\n\n" if @source
      str += "#{@ruby.tr('\"', '\'')}\n\n" if @ruby
      str
    end

    def parse_ruby
      /^(ruby.*)/.match(@gemfile_contents)[1]
    end

    def parse_source
      /^(source.*)/.match(@gemfile_contents)[1]
    end
  end
end
