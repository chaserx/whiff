# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'whiff/version'

Gem::Specification.new do |spec|
  spec.name          = "whiff"
  spec.version       = Whiff::VERSION
  spec.authors       = ["Chase Southard"]
  spec.email         = ["chase.southard@gmail.com"]
  spec.summary       = %q{A ruby wrapper for arp-scan.}
  spec.description   = %q{A ruby wrapper for arp-scan. Returns array of MAC addresses}
  spec.homepage      = "https://github.com/chaserx/whiff"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "pry"
end
