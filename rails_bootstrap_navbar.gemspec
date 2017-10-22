# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rails-bootstrap-navbar/version'

Gem::Specification.new do |gem|
  gem.name          = 'rails_bootstrap_navbar'
  gem.version       = RailsBootstrapNavbar::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.author        = 'Manuel Meurer'
  gem.email         = 'manuel@krautcomputing.com'
  gem.description   = 'Easily generate a Bootstrap navbar in your Rails app'
  gem.summary       = 'Easily generate a Bootstrap navbar in your Rails app'
  gem.homepage      = 'http://bootstrap-ruby.github.io/rails-bootstrap-navbar'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r(^bin/)).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r(^(test|spec|features)/))
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake', '< 11.0'
  gem.add_development_dependency 'rspec', '~> 2.13'
  gem.add_development_dependency 'guard-rspec', '~> 3.0'

  gem.add_runtime_dependency 'bootstrap-navbar', '~> 3.0'
  gem.add_runtime_dependency 'rails', '>= 3.0.0'
end
