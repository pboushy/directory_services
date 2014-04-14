require 'directory_services'

describe DirectoryServices do
    before(:all) do
        DirectoryServices.configure do |config|
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
        users = DirectoryServices::User.all
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

    it "should be able to disable an active user" do
        DirectoryServices::User.disable(@username)
        DirectoryServices::User.active?(@username).should_not == true
    end

    it "should be able to enable an inactive user" do
        DirectoryServices::User.enable(@username)
        DirectoryServices::User.active?(@username).should == true
    end

    it "should check user authentication" do
        DirectoryServices::User.auth(@username, @password).should == true
        password = "badpass"
        DirectoryServices::User.auth(@username, password).should == false
    end

    it "should delete an existing user" do
        DirectoryServices::User.delete(@username)
        DirectoryServices::User.exists?(@username).should == false
    end
end
