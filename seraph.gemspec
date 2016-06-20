# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seraph/version'
require 'English'

Gem::Specification.new do |gem|
  gem.name          = 'seraph'
  gem.version       = Seraph::VERSION
  gem.summary       = 'A simple framework-agnostic library for authentication'
  gem.description   = "Looking for an authentication gem that doesn't make any assumptions about your setup? You've came to the right place."
  gem.license       = 'MIT'
  gem.authors       = ['Szymon Szeliga']
  gem.email         = 'szeliga.szymon@gmail.com'
  gem.homepage      = 'https://rubygems.org/gems/seraph'

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)

  `git submodule --quiet foreach --recursive pwd`.split($INPUT_RECORD_SEPARATOR).each do |submodule|
    submodule.sub!("#{Dir.pwd}/", '')

    Dir.chdir(submodule) do
      `git ls-files`.split($INPUT_RECORD_SEPARATOR).map do |subpath|
        gem.files << File.join(submodule, subpath)
      end
    end
  end
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'bcrypt', '~> 3.1'
  gem.add_dependency 'fast_secure_compare', '~> 1.0'
  gem.add_dependency 'fast_blank', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 11.2'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'fuubar', '~> 2.0'
  gem.add_development_dependency 'pry', '~> 0.10'
  gem.add_development_dependency 'codeclimate-test-reporter', '~> 0.1'
end
