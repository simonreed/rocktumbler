require 'open-uri'
require 'ostruct'
require 'tempfile'
require 'bundler'

# Rocktumbler module
module Rocktumbler
  autoload :Tumbler,       'rocktumbler/tumbler'
  autoload :Group,         'rocktumbler/group'
  autoload :GroupFilter,   'rocktumbler/group_filter'
  autoload :Gem,           'rocktumbler/gem'
  autoload :Gemfile,       'rocktumbler/gemfile'
  autoload :Version,       'rocktumbler/version'
end
