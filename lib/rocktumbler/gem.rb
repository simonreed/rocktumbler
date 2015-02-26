require_relative 'exceptions'

module Rocktumbler
  class Gem
    def initialize(gem_dependency)
      @gem_dependency = gem_dependency
    end

    def print(prepend="")
      gem_info = retrieve_gem_information(@gem_dependency.name)
      str = "#{prepend}# #{gem_info.summary}\n"
      str += "#{prepend}# #{gem_info.homepage}\n"
      str += "#{prepend}gem '#{@gem_dependency.name}'"
      str += ",'#{@gem_dependency.requirement}'" if @gem_dependency.requirement.specific?
      str += generate_gem_source(@gem_dependency.source.options) if @gem_dependency.source
      str += ", require: #{!@gem_dependency.autorequire.empty?}" if @gem_dependency.autorequire
      str += "\n\n"
    end

    def generate_gem_source(source_options)
      return ", github: '#{source_options['github']}'" if source_options['github']
      return ", path: '#{source_options['path']}'" if source_options['path']
    end

    def retrieve_gem_information(gem_name)
      bundled_gem = Bundler.definition.specs.select{|g| g.name == gem_name}.first
      if bundled_gem
        OpenStruct.new(summary: bundled_gem.summary.slice(0,80), homepage: bundled_gem.homepage)
      else
        rubygems_gem_information(gem_name)
      end
    end

    def rubygems_gem_information(gem_name)
      begin
        json = open("https://rubygems.org/api/v1/gems/#{gem_name}.json").read
        gem_info = JSON.parse(json)
        OpenStruct.new(summary: gem_info['info'].slice(0,80), homepage: gem_info['homepage_uri'])
      rescue OpenURI::HTTPError => e
        if e.message == '404 Not Found'
          raise GemInformationNotFoundError, "No details found locally or on rubygems for '#{gem_name}'"
        else
          raise e
        end
      end
    end
  end
end
