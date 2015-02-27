$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rocktumbler'

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
