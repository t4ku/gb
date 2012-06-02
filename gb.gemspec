# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gb/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["t4ku"]
  gem.email         = ["taku.okawa@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.add_dependency('json')
  gem.add_dependency('httparty')
  gem.add_development_dependency('cucumber')
  gem.add_development_dependency('fakefs')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('guard')
  gem.add_development_dependency('guard-rspec')
  gem.add_development_dependency('guard-cucumber')

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gb"
  gem.require_paths = ["lib"]
  gem.version       = Gb::VERSION
end
