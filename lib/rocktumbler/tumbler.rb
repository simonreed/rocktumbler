require_relative 'exceptions'

module Rocktumbler
  # The Tumbler class is responsible for executing the top level tumble method
  # and reads, parses, cleans, writes and verifies the new gemfile.
  class Tumbler

    def initialize(opts, location = Bundler.default_gemfile)
      @opts = opts
      @gemfile_location = location
      @bundler_dependencies = parse_gemfile(@gemfile_location)
      @original_gemfile_str = File.open(@gemfile_location).read
      @gemfile = Rocktumbler::Gemfile.new(location)
    end

    def tumble
      groups = Rocktumbler::GroupFilter.new(@bundler_dependencies, @opts).filter
      clean_gemfile_str = @gemfile.print_source_and_ruby
      clean_gemfile_str << groups.map(&:print).join
      if clean_gemfile_str == @original_gemfile_str
        print "No changes required to Gemfile\n".colorize(:yellow)
      else
        compare_to_original_gemfile(clean_gemfile_str)
        write(clean_gemfile_str) unless @opts.skip_write
        print "New Gemfile generated and written to \
#{@gemfile_location}\n".colorize(:green)
        verbose_highlight(clean_gemfile_str) if @opts.verbose
      end
    end

    private

    def verbose_highlight(source)
      print "\n"
      formatter = Rouge::Formatters::Terminal256.new(theme: 'github')
      lexer = Rouge::Lexers::Ruby.new
      print formatter.format(lexer.lex(source))
      print "\n"
    end

    def write(clean_gemfile_str)
      gemfile = File.open(@gemfile_location, 'w')
      gemfile.write(clean_gemfile_str)
      gemfile.close
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
