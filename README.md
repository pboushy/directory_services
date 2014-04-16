# DirectoryServices

Allows interacting with Apple's "Open Directory", Microsoft's "Active Directory", or LDAP through OS X's DirectoryServices.



## Installation

Add this line to your application's Gemfile:

    gem 'directory_services'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install directory_services

## Configure

There are two ways to configure directory_services.

### ENV Variables

Please add the following ENV variables:
	
	RUN_LOCALLY (optional, defaults to 'yes')
	HOST_NAME
	HOST_USERNAME
	HOST_PASSWORD
	OD_USERNAME
	OD_PASSWORD
	OD_DATASOURCE (optional, defaults to '/LDAPv3/127.0.0.1')

The easiest way to add these is through command line:

	export ENV_VARIABLE="value"

### Programatically
	
	OpenDirectory.configure do |config|
		config.run_locally = 'yes' # default='yes'
		config.host_name = 'yourhost.com'
		config.host_username = 'sshadmin'
		config.host_password = 'sshpassword'
		config.od_username = 'diradmin'
		config.od_password = 'diradminpass'
		config.od_datasource = 'LDAPv3/127.0.0.1' # default = '/LDAPv3/127.0.0.1'
	end


## Contributing
