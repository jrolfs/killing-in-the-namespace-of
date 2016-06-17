# coding: utf-8
#
lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'kitno/version'

Gem::Specification.new do |spec|
  spec.name          = 'kitno'
  spec.version       = Kitno::VERSION
  spec.authors       = ['Jamie Rolfs', 'Alan Wong', 'Cassandra Cruz']
  spec.email         = ['jamie.rolfs@gmail.com', 'alan@mavenlink.com', 'celkamada@gmail.com']

  spec.summary       = 'Killing In The Namespace Of'
  spec.description   = 'Convert projects that use JavaScript namespace module structures to CommonJS'
  spec.homepage      = 'https://github.com/jrolfs/killing-in-the-namespace-of'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor', '~> 0.19.1'
  spec.add_dependency 'awesome_print', '~> 1.7.0', '>= 1.7.0'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'gem-release', '~> 0.7.4'
end
