# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serafin/version'
require 'English'

Gem::Specification.new do |gem|
  gem.name          = 'serafin'
  gem.version       = Serafin::VERSION
  gem.summary       = 'A simple framework-agnostic library for authentication'
  gem.description   = "Looking for an authentication gem that doesn't make any assumptions about your setup? You've came to the right place."
  gem.license       = 'MIT'
  gem.authors       = ['Szymon Szeliga']
  gem.email         = 'szeliga.szymon@gmail.com'
  gem.homepage      = 'https://rubygems.org/gems/serafin'

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)

  `git submodule --quiet foreach --recursive pwd`.split($/).each do |submodule|
    submodule.sub!("#{Dir.pwd}/", '')

    Dir.chdir(submodule) do
      `git ls-files`.split($/).map do |subpath|
        gem.files << File.join(submodule,subpath)
      end
    end
  end
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'bcrypt', '~> 3.1.6'
  gem.add_development_dependency 'bundler', '~> 1.10'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency "fuubar"
end
