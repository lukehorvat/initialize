# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'initialize/version'

Gem::Specification.new do |spec|
  spec.name          = "initialize"
  spec.version       = Initialize::VERSION
  spec.authors       = ["Luke Horvat"]
  spec.email         = ["lukehorvat@gmail.com"]
  spec.summary       = %q{Ruby gem.}
  spec.description   = %q{Ruby gem.}
  spec.homepage      = "https://github.com/lukehorvat/initialize"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
