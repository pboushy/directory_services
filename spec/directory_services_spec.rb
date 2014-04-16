require 'directory_services'

describe DirectoryServices do
	before(:all) do
		DirectoryServices.load_env
		@username = 'jdoe'
		@password = 'super5ecret!'
	end

	it "should list all users" do
		users = DirectoryServices::User.all
		users.class.should == Array
		users.size.should_not == 0
	end

	it "should create a new user" do
		params = {
			:UniqueID => '9999',
			:PrimaryGroupID => '20',
			:NFSHomeDirectory => '/Users/jdoe',
			:UserShell => '/bin/bash',
			:RealName => 'John Doe',
			:LastName => 'Doe',
			:FirstName => 'John',
			:EMailAddress => 'jdoe@johndoe.com',
			:Keywords => ['test', 'ruby']
		}
		DirectoryServices::User.create(@username, @password, params)
		DirectoryServices::User.exists?(@username).should == true
	end

	it "should know if a user exists" do
		DirectoryServices::User.exists?(@username).should == true
		username = "idontexists"
		DirectoryServices::User.exists?(username).should == false
	end

	it "should read an existing user" do
		record = DirectoryServices::User.read(@username)
		record["dsAttrTypeStandard:RecordName"][0].should == @username
		username = "idontexists"
		DirectoryServices::User.read(username).should == false
	end

	it "should know if a user is active" do
		DirectoryServices::User.active?(@username).should == true
	end
=begin
	it "should be able to disable an active user" do
		DirectoryServices::User.disable(@username)
		DirectoryServices::User.active?(@username).should_not == true
	end

	it "should be able to enable an inactive user" do
		DirectoryServices::User.enable(@username)
		DirectoryServices::User.active?(@username).should == true
	end
=end
	it "should check if a user's password is correct" do
		DirectoryServices::User.auth(@username, @password).should == true
		password = 'badpass'
		DirectoryServices::User.auth(@username, password).should == false
	end
=begin
	it "should delete an existing user" do
		DirectoryServices::User.delete(@username)
		DirectoryServices::User.exists?(@username).should == false
	end
=end	
end
