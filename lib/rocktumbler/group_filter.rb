module Rocktumbler
  class GroupFilter
    def initialize(gem_dependencies)
      @gem_dependencies = gem_dependencies
    end

    def filter
      gems_by_group = @gem_dependencies.group_by(&:groups)

      default_gems = gems_by_group.delete([:default])
      default_gems.sort!
      groups = [Rocktumbler::Group.new(:default,default_gems)]

      gems_by_group.each do | group, gems |
        gems_unique_to_group = gems - default_gems
        gems_unique_to_group.sort!
        gems_unique_to_group.uniq!
        groups << Rocktumbler::Group.new(group,gems_unique_to_group)
      end

      return groups
    end
  end
end
