module Rocktumbler
  class Group

    attr_accessor :name

    def initialize(name,gem_dependencies)
      @name = name
      @gems = gem_dependencies.map{|g| Rocktumbler::Gem.new(g)}
    end

    def print
      str = ''
      prepend_spacing = (@name == :default) ? '' : '  '
      str += "\n\ngroup #{@name.to_s.gsub(/[\[\]]/,'')} do\n" if @name != :default
      str += @gems.map{|g|g.print(prepend_spacing)}.join
      str += "end\n" if @name != :default
      return str
    end
  end
end
