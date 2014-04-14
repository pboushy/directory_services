# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'directory_services/version'

Gem::Specification.new do |gem|
  gem.name          = "directory_services"
  gem.version       = DirectoryServices::VERSION
  gem.licenses      = ['MIT']
  gem.description   = "Interact with OS X DirectoryServices allowing communication with OpenDirectory, 
                      ActiveDirectory, and LDAP when connected to an OS X Client or Server."
  gem.summary       = "Interacts with OS X DirectoryServices"
  

  gem.authors       = ["Phillip Boushy"]
  gem.email         = ["Phillip@Boushy.com"]
  gem.homepage      = "https://github.com/prbsparx/directory-services"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency "plist"
  gem.add_dependency "net-ssh"

  gem.add_development_dependency "rspec", "~> 2.6"
end
