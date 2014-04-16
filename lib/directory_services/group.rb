module DirectoryServices
    class Group
    	def self.all
			Dscl.generate("list","/Groups")
			Dscl.run
    	end

    	def self.exists?(groupname)
    		groups = all
			groups.include?(groupname)
    	end

    	def self.get_users_in_group(groupname)
    		if exists?(groupname)
    			params = [
    						"GroupMembership",
    						"NestedGroups"
    					]
    			Dscl.generate("read","/Groups/#{groupname}",params)
    			output = Dscl.run(debug)
    			puts output
    		end
    	end
    end
end