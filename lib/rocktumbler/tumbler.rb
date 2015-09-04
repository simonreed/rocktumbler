require_relative 'exceptions'

module Rocktumbler
  # The Tumbler class is responsible for executing the top level tumble method
  # and reads, parses, cleans, writes and verifies the new gemfile.
  class Tumbler
    def initialize(location = Bundler.default_gemfile)
      @opts = {}
      @gemfile_location = location
      @bundler_dependencies = parse_gemfile(@gemfile_location)
      @gemfile = Rocktumbler::Gemfile.new(location)
    end

    def tumble(args = ARGV)
      @opts = Option.parse(args)
      groups = Rocktumbler::GroupFilter.new(@bundler_dependencies, @opts).filter
      clean_gemfile_str = @gemfile.print_source_and_ruby
      clean_gemfile_str << groups.map(&:print).join
      compare_to_original_gemfile(clean_gemfile_str)
      write(clean_gemfile_str) unless @opts.skip_write
      clean_gemfile_str
    end

    def compare_to_original_gemfile(clean_gemfile_str)
      temp_gemfile = write_temp_gemfile(clean_gemfile_str)
      temp_bundler_dependencies = parse_gemfile(temp_gemfile.path)
      diff = @bundler_dependencies - temp_bundler_dependencies

      if diff.empty?
        return true
      else
        fail IncomparableGemfileError, "Clean Gemfile is not comparable to the\
 existing Gemfile. The following gems are missing : #{diff.map(&:name)}."
      end
    end

    def write(clean_gemfile_str)
      gemfile = File.open(@gemfile_location, 'w')
      gemfile.write(clean_gemfile_str)
      gemfile.close
    end

    private

    def write_temp_gemfile(clean_gemfile_str)
      temp_gemfile = Tempfile.new('Gemfile.temp')
      temp_gemfile.write(clean_gemfile_str)
      temp_gemfile.close
      temp_gemfile
    end

    def parse_gemfile(location)
      builder = Bundler::Dsl.new
      builder.eval_gemfile(location)
    end
  end
end
