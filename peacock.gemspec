# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'peacock/version'

Gem::Specification.new do |spec|
  spec.name          = "peacock"
  spec.version       = Peacock::VERSION
  spec.authors       = ["David Clarke"]
  spec.email         = ["terrorhawks@gmail.com"]
  spec.description   = %q{A capistrano plugin for blue green deployments for AWS ELB}
  spec.summary       = %q{Seem readme}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
