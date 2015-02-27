# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rocktumbler/version'

Gem::Specification.new do |spec|
  spec.name          = "rocktumbler"
  spec.version       = Rocktumbler::VERSION
  spec.authors       = ["Simon Reed"]
  spec.email         = ["simonpreed@gmail.com"]

  spec.summary       = %q{Polish your Gemfile to make sure it remains consistent.}
  spec.description   = %q{Polish your Gemfile to make sure it remains consistent.}
  spec.homepage      = "https://github.com/simonreed/rocktumbler"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = %w(tumble)
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "bundler", "~> 1.8"
end
