Gem::Specification.new do |gem|
  gem.name        = 'kitno'
  gem.version     = '0.0.1'
  gem.date        = '2016-04-29'
  gem.summary     = 'Convert projects that use JavaScript namespace module structures to CommonJS'
  gem.description = ''
  gem.authors     = ['Jamie Rolfs, Alan Wong']
  gem.email       = ['jamie@mavenlink.com', 'alan@mavenlink.com']
  gem.files       = ['lib/kitno.rb']
  gem.homepage    = ''
  gem.license     = 'MIT'

  gem.files         = Dir['**/*']
  gem.require_paths = ['lib']

  gem.add_development_dependency 'find'
  gem.add_development_dependency 'fileutils'
end
