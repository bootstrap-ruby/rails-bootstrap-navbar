# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rails_bootstrap_navbar/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jules Copeland"]
  gem.email         = ["jules@julescopeland.com"]
  gem.description   = %q{A helper method for easy generation of Twitter Bootstrap Navigation menus in Rails}
  gem.summary       = %q{Generate Bootstrap Navbars in Rails views}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rails_bootstrap_navbar"
  gem.require_paths = ["lib"]
  gem.version       = RailsBootstrapNavbar::VERSION

  gem.add_development_dependency 'rake', '>= 10.0.0'
  gem.add_development_dependency 'rspec', '~> 2.13'
  gem.add_development_dependency 'guard-rspec', '~> 3.0'
  gem.add_development_dependency 'rails', '>= 3.0.0'

  gem.add_runtime_dependency 'bootstrap_navbar', '~> 0.0.10'
  gem.add_runtime_dependency 'rails', '>= 3.0.0'
end
