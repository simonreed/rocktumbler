module Rocktumbler
  # The Group is a class responsible for outputting a gem group
  class Group
    attr_accessor :name

    def initialize(name, gem_dependencies)
      @name = name
      @gems = gem_dependencies.map { |g| Rocktumbler::Gem.new(g) }
    end

    def print
      str = ''
      prepend_spacing = (@name == :default) ? '' : '  '
      if @name != :default
        str += "\ngroup #{@name.to_s.gsub(/[\[\]]/, '')} do\n"
      end
      str += @gems.map { |g| g.print(prepend_spacing) }.join("\n\n")
      str += "\nend\n" if @name != :default
      str
    end
  end
end
