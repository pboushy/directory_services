# DirectoryServices

Allows interacting with Apple's "Open Directory", Microsoft's "Active Directory", or LDAP through OS X's DirectoryServices.


## Installation

    gem install directory_services

OR:

Add this line to your application's Gemfile:

    gem 'directory_services'

And then execute:

    bundle

## Configure

There are two ways to configure directory_services.

### ENV Variables

Tell your app that you want to load the configuration from environment variables:
	
	DirectoryServices.load_env

And create the environment variables:

	export RUN_LOCALLY='yes' # default='yes'
	export HOST_NAME='yourhost.com' 
	export HOST_USERNAME='localadmin'
	export HOST_PASSWORD='localpass'
	export OD_USERNAME='diradmin'
	export OD_PASSWORD='dirpass'
	export OD_DATASOURCE='/LDAPv3/127.0.0.1' # default='/LDAPv3/127.0.0.1'

### Programatically
	
	DirectoryServices.configure do |config|
		config.run_locally = 'yes' # default='yes'
		config.host_name = 'yourhost.com'
		config.host_username = 'sshadmin'
		config.host_password = 'sshpassword'
		config.od_username = 'diradmin'
		config.od_password = 'diradminpass'
		config.od_datasource = '/LDAPv3/127.0.0.1' # default = '/LDAPv3/127.0.0.1'
	end


## Contributing

I would love to have some more experienced ruby/rails/gem developers point me in the right direction to make this a better gem. 

### Things I would like assistance on learning how to

- setup Users to act more like an actual object (maybe even based off of ActiveRecord?)
- setup Groups to act more like an actual object (maybe even based off of ActiveRecord?)
- setup Users and Groups to be related (purpose: get list of groups for user by phillip.groups where phillip is a User object)
- make it where if the directory store is AD it pulls different information automatically without a series of complicated if/then statements.
- any recommendations on additional things to add