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

## Current Thoughts on "DirectoryServices"

Currently I feel it is mostly a gem full of methods tossed into classes for organization... this is mostly due to the original gem I branched and my inexperience as a ruby developer.

### This to accomplish in the future:

I would love to update it to include actual user and group objects that allow the user to get a user and group info through properties. (e.g. phillip.groups)
Customize to allow pulling from OD or AD with some customization. I'd like for the code to intelligently pull users and groups from both stores if necessary.