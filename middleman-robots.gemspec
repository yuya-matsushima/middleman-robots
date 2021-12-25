# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman-robots/version'

Gem::Specification.new do |spec|
  spec.name          = 'middleman-robots'
  spec.version       = Middleman::Robots::VERSION
  spec.authors       = ['Yuya Matsushima']
  spec.email         = ['terra@e2esound.com']
  spec.summary       = 'Generate robots.txt by config.rb.'
  spec.description   = 'middleman-robots create robots.txt includes Allow or Disallow and sitemap path.'
  spec.homepage      = 'https://github.com/yterajima/middleman-robots'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.6.0'

  spec.add_runtime_dependency 'middleman-cli', '~> 4.0'
  spec.add_runtime_dependency 'middleman-core', '~> 4.0'

  spec.add_development_dependency 'aruba', '>= 0.14.3'
  spec.add_development_dependency 'bundler', '>= 1.16'
  spec.add_development_dependency 'capybara', '>= 2.18.0'
  spec.add_development_dependency 'cucumber', '>= 3.1.0'
  spec.add_development_dependency 'rake', '>= 12.3'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop', '>= 0.52.1'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
