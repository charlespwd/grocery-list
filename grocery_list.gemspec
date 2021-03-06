# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grocery_list/version'

Gem::Specification.new do |spec|
  spec.name          = "grocery_list"
  spec.version       = GroceryList::VERSION
  spec.authors       = ["Charles-P. Clermont"]
  spec.email         = ["charles.pclermont@gmail.com"]
  spec.summary       = %q{Turn your json, csv, md, or strings into grocery lists that you can then search for.}
  # spec.description   = %q{}
  spec.homepage      = "https://github.com/charlespwd/grocery-list"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "launchy", "~> 2.4"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
