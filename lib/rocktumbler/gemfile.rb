require_relative 'exceptions'

module Rocktumbler
  class Gemfile
    attr_accessor :ruby, :source

    def initialize(gemfile_location)
      @gemfile_location = gemfile_location
      @gemfile_contents = read_contents
      @ruby = parse_ruby
      @source = parse_source
    end

    def read_contents
      gemfile = File.open(@gemfile_location,'r')
      str = gemfile.read
      gemfile.close
      str
    end

    def print_source_and_ruby
      str = ""
      str += "#{@source.gsub(/"/,'\'')}\n\n" if @source
      str += "#{@ruby.gsub(/"/,'\'')}\n\n" if @ruby
      str
    end

    def parse_ruby
      /^(ruby.*)/.match(@gemfile_contents)
      $1
    end

    def parse_source
      /^(source.*)/.match(@gemfile_contents)
      $1
    end
  end
end
