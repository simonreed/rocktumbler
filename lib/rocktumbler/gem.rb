require_relative 'exceptions'

module Rocktumbler
  # The Gem is a class responsible for handling outputting info on a Rubygem
  class Gem
    def initialize(gem_dep, opts)
      @gem_dep = gem_dep
      @opts = opts
    end

    def print(prepend = '')
      max_length = 80 - 2 - prepend.chars.count
      gem_info = retrieve_gem_information(@gem_dep.name, max_length)
      formatted_line(prepend, gem_info)
    end

    private

    def formatted_line(prepend, gem_info)
      if @opts.docs
        str = "#{prepend}# #{gem_info.summary.strip}\n"
        str += format_homepage(gem_info.homepage, prepend)
      else
        str = ''
      end
      str += "#{prepend}gem '#{@gem_dep.name}'"
      str += format_requirement || ''
      str += format_source
      str += format_require(@gem_dep.autorequire)
      str
    end

    def format_requirement
      ", '#{@gem_dep.requirement}'" unless @gem_dep.requirement.none?
    end

    def format_homepage(homepage, prepend)
      (homepage.nil?) ? "#{prepend}#\n" : "#{prepend}# #{homepage}\n"
    end

    def format_require(autorequire)
      return '' unless autorequire
      if autorequire.count > 1
        # Array.to_s will output double quotes so we gsub them to singles.
        return ", require: #{autorequire.to_s.tr('"', '\'')}"
      elsif autorequire.first.is_a?(String)
        return ", require: '#{autorequire.first}'"
      else
        return ", require: #{!autorequire.empty?}"
      end
    end

    def format_source
      return '' unless @gem_dep.source
      source_options = @gem_dep.source.options
      %w(git github git_source source path gist bitbucket).each do |source_type|
        next unless source_options[source_type]
        return ", #{source_type}: '#{source_options[source_type]}'"
      end
    end

    def retrieve_gem_information(gem_name, max_length = 80)
      bundled_gem = Bundler.definition.specs.find { |g| g.name == gem_name }
      if bundled_gem
        OpenStruct.new(summary: bundled_gem.summary.slice(0, max_length),
                       homepage: bundled_gem.homepage)
      else
        rubygems_gem_info(gem_name, max_length)
      end
    end

    def rubygems_gem_info(gem_name, max_length = 80)
      gem_info = rubygems_gem_info_json(gem_name)
      OpenStruct.new(summary: gem_info['info'].slice(0, max_length),
                     homepage: gem_info['homepage_uri'])
    rescue OpenURI::HTTPError => e
      if e.message == '404 Not Found'
        raise GemInformationNotFoundError,
              "No details found locally or on rubygems for '#{gem_name}'"
      else
        raise e
      end
    end

    def rubygems_gem_info_json(gem_name)
      json = open("https://rubygems.org/api/v1/gems/#{gem_name}.json").read
      JSON.parse(json)
    end
  end
end
