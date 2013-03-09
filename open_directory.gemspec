# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_directory/version'

Gem::Specification.new do |gem|
  gem.name          = "open_directory"
  gem.version       = OpenDirectory::VERSION
  gem.authors       = ["Mauro Morales"]
  gem.email         = ["contact@mauromorales.com"]
  gem.description   = "Interact with Open Directory"
  gem.summary       = "Generate dscl commands and run them on OD"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency "plist"
  gem.add_dependency "net-ssh"

  gem.add_development_dependency "rspec", "~> 2.6"
end
