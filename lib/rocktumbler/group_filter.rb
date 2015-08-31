module Rocktumbler
  # The GroupFilter is a class responsible for filtering gems into group
  # and sorting the groups and their gems alphabetically.
  class GroupFilter
    def initialize(gem_dependencies)
      @gem_dependencies = gem_dependencies
    end

    def filter
      gems_by_group = @gem_dependencies.group_by(&:groups)

      default_gems = gems_by_group.delete([:default])
      default_gems.sort!
      groups = [Rocktumbler::Group.new(:default, default_gems)]

      gems_by_group_sorted = sort_groups(gems_by_group, default_gems)

      groups.concat(gems_by_group_sorted)
    end

    private

    def sort_groups(gems_by_group, default_gems)
      gems_by_group.inject([]) do |arr, (group, gems)|
        gems_unique_to_group = gems - default_gems
        gems_unique_to_group.sort!
        gems_unique_to_group.uniq!
        arr << Rocktumbler::Group.new(group, gems_unique_to_group)
      end
    end
  end
end
