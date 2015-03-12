require_relative 'exceptions'

module Rocktumbler
  class Tumbler
    def initialize(location=Bundler.default_gemfile)
      @gemfile_location = location
      @bundler_dependencies = parse_gemfile(@gemfile_location)
      @gemfile = Rocktumbler::Gemfile.new(location)
    end

    def tumble(opts={})
      groups = Rocktumbler::GroupFilter.new(@bundler_dependencies).filter
      clean_gemfile_str = @gemfile.print_source_and_ruby
      clean_gemfile_str << groups.map(&:print).join
      compare_to_original_gemfile(clean_gemfile_str)
      write(clean_gemfile_str) unless opts[:skip_write]
      return clean_gemfile_str
    end

    def compare_to_original_gemfile(clean_gemfile_str)
      temp_gemfile = Tempfile.new('Gemfile.temp')
      temp_gemfile.write(clean_gemfile_str)
      temp_gemfile.close
      temp_bundler_dependencies = parse_gemfile(temp_gemfile.path)
      diff = @bundler_dependencies - temp_bundler_dependencies

      if diff.empty?
        return true
      else
        raise IncomparableGemfileError, "Clean Gemfile is not comparable to the existing Gemfile. The following gems are missing : #{diff.map(&:name).to_s}."
      end
    end

    def write(clean_gemfile_str)
      gemfile = File.open(@gemfile_location,'w')
      gemfile.write(clean_gemfile_str)
      gemfile.close
    end

    private

    def parse_gemfile(location)
      builder = Bundler::Dsl.new
      builder.eval_gemfile(location)
    end
  end
end
