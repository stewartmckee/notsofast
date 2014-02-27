# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'notsofast/version'

Gem::Specification.new do |spec|
  spec.name          = "notsofast"
  spec.version       = Notsofast::VERSION
  spec.authors       = ["Stewart McKee"]
  spec.email         = ["stewart@theizone.co.uk"]
  spec.description   = "Rate limiting gem based on ip or cookie"
  spec.summary       = "Rate limiting gem based on ip or cookie"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
