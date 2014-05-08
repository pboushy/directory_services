# -*- encoding: utf-8 -*-
=begin
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
=end

# -- this is magic line that ensures "../lib" is in the load path -------------
$:.push File.expand_path("../lib", __FILE__)

require 'directory_services/version'

Gem::Specification.new do |s|
	s.name          = "directory_services"
	s.version       = DirectoryServices::VERSION
	s.authors       = ["Phillip Boushy"]
	s.email         = ["Phillip@Boushy.com"]
	s.homepage      = "https://github.com/prbsparx/directory-services"
	s.summary       = "Interacts with OS X DirectoryServices"
	s.description   = "Interact with OS X DirectoryServices allowing communication with OpenDirectory, ActiveDirectory, and LDAP when connected to an OS X Client or Server."
	s.licenses      = ['MIT']

	# s.files: The files included in the gem. This clever use of git ls-files
	#          ensures that any files tracked in the git repo will be included.
 	s.files         = `git ls-files`.split("\n")

	# s.test_files: Files that are used for testing the gem. This line cleverly
	#               supports TestUnit, MiniTest, RSpec, and Cucumber
	s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

	# s.executables: Where any executable files included with the gem live.
	#                These go in bin by convention.
	s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

	# s.require_paths: Directories within the gem that need to be loaded in order
	#                  to load the gem.
	s.require_paths = ["lib"]
	
	s.add_dependency "plist"
	s.add_dependency "net-ssh"

	s.add_development_dependency "rake"
	s.add_development_dependency "rspec", "~> 2.6"
end
