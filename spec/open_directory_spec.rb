require 'open_directory'

describe OpenDirectory do
    before(:all) do
        OpenDirectory.configure do |config|
            config.host_name = 'yourhost.com'
            config.host_username = 'deploy'
            config.host_password = 'd3pl0y'
            config.od_username = 'admin'
            config.od_password = '4dm1n'
        end

        @username = 'jdoe'
        @password = 'super5ecret!'
    end

    it "should list all users" do
        users = OpenDirectory::User.all
        users.class.should == Array
        users.size.should_not == 0
    end

    it "should create a new user" do
        params = { :UniqueID => '9999',
                   :LastName => 'Doe',
                   :FirstName => 'John',
                   :EMailAddress => 'jdoe@johndoe.com',
                   :Keywords => ['test', 'ruby']
        }
        OpenDirectory::User.create(@username, @password, params)
        OpenDirectory::User.exists?(@username).should == true
    end

    it "should know if a user exists" do
        OpenDirectory::User.exists?(@username).should == true
        username = "idontexists"
        OpenDirectory::User.exists?(username).should == false
    end

    it "should read an existing user" do
        record = OpenDirectory::User.read(@username)
        record["dsAttrTypeStandard:RecordName"][0].should == @username
        username = "idontexists"
        OpenDirectory::User.read(username).should == false
    end

    it "should know if a user is active" do
        OpenDirectory::User.active?(@username).should == true
    end

    it "should be able to disable an active user" do
        OpenDirectory::User.disable(@username)
        OpenDirectory::User.active?(@username).should_not == true
    end

    it "should be able to enable an inactive user" do
        OpenDirectory::User.enable(@username)
        OpenDirectory::User.active?(@username).should == true
    end

    it "should check user authentication" do
        OpenDirectory::User.auth(@username, @password).should == true
        password = "badpass"
        OpenDirectory::User.auth(@username, password).should == false
    end

    it "should delete an existing user" do
        OpenDirectory::User.delete(@username)
        OpenDirectory::User.exists?(@username).should == false
    end
end
