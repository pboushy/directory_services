module DirectoryServices
	class User
		def self.all
			DSQuery.generate_dscl("list", "/Users")
			DSQuery.run
		end

		def self.exists?(username)
			users = all
			users.include?(username)
		end

		def self.read(username, params="")
			if exists?(username)
				DSQuery.generate_dscl("read", "/Users/#{username}",params)
				DSQuery.run
			else
				false
			end
		end

		def self.auth(username, password)
			params = ["'#{password}'"]
			DSQuery.generate_dscl("authonly", username, params)
			output = DSQuery.run
			if output.empty?
				return true
			else
				return false
			end
		end

		def self.base_script(username, params=[])
			params.each do |key, value|
				if key == :Keywords
					value.each do |keyword|
						DSQuery.generate_dscl("append", "/Users/#{username}", [key, "'#{keyword}'"])
					end
				else
					DSQuery.generate_dscl("create", "/Users/#{username}", [key, "'#{value}'"])
				end
			end
		end

		def self.update(username, password=nil, params=[])
		  base_script(username, password, params)
		  DSQuery.run
		end

		def self.create(username, password, params=[])
		  DSQuery.generate_dscl("create", "/Users/#{username}")
		  DSQuery.generate_dscl("passwd", "/Users/#{username}", ["'#{password}'"])
		  base_script(username, params)
		  DSQuery.run
		end

		def self.delete(username)
			DSQuery.generate_dscl("delete", "/Users/#{username}")
			DSQuery.run
		end

		def self.active?(username)
			record = read(username, ["AuthenticationAuthority"])
			!record["dsAttrTypeStandard:AuthenticationAuthority"].include? ";DisabledUser;"
		end

		def self.disable(username)
			params = %w(AuthenticationAuthority ';DisabledUser;')
			DSQuery.generate_dscl("append", "/Users/#{username}", params)
			DSQuery.run
		end

		def self.enable(username)
			response = read(username, ["AuthenticationAuthority"])
			response["dsAttrTypeStandard:AuthenticationAuthority"].delete(";DisabledUser;")
			params = ["dsAttrTypeStandard:AuthenticationAuthority", "'" + response["dsAttrTypeStandard:AuthenticationAuthority"].join(" ") + "'"]
			DSQuery.generate_dscl("create", "/Users/#{username}", params)
			DSQuery.run
		end

		def self.change_password(username, password)
		  DSQuery.generate_dscl("passwd", "/Users/#{username}", ["'#{password}'"])
		  DSQuery.run
		end

	end
end
