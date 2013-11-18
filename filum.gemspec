# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filum/version'

Gem::Specification.new do |spec|
  spec.name          = "filum"
  spec.version       = Filum::VERSION
  spec.authors       = ["MalcyL"]
  spec.email         = ["malcolm@landonsonline.me.uk"]
  spec.description   = %q{Logging framework storing context id in thread local}
  spec.summary       = %q{Identifies the context of log lines using a context id stored in Thread local}
  spec.homepage      = ""
  spec.license       = "AGPL3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "minitest", "~> 5.0.8"
end
