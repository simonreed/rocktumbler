require 'open-uri'
require 'ostruct'
require 'tempfile'
require 'bundler'
require 'colorize'
require 'rouge'

# Rocktumbler module
module Rocktumbler
  autoload :CLI,           'rocktumbler/cli'
  autoload :Tumbler,       'rocktumbler/tumbler'
  autoload :Group,         'rocktumbler/group'
  autoload :GroupFilter,   'rocktumbler/group_filter'
  autoload :Gem,           'rocktumbler/gem'
  autoload :Gemfile,       'rocktumbler/gemfile'
  autoload :VERSION,       'rocktumbler/version'
  autoload :Option,        'rocktumbler/option'
end
