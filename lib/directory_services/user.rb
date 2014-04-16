module DirectoryServices
	class User
		def self.all
			Dscl.generate("list", "/Users")
			Dscl.run
		end

		def self.exists?(username)
			users = all
			users.include?(username)
		end

		def self.read(username, params="")
			if exists?(username)
				Dscl.generate("read", "/Users/#{username}",params)
				Dscl.run
			else
				false
			end
		end

		def self.auth(username, password)
			params = ["'#{password}'"]
			Dscl.generate("authonly", username, params)
			output = Dscl.run
			if output.empty?
				true
			else
				false
			end
		end

		def self.base_script(username, password=nil, params=[])
			#Dscl.generate("passwd", "/Users/#{username}", ["'#{password}'"]) unless password.nil?
			params.each do |key, value|
				if key == :Keywords
					value.each do |keyword|
						Dscl.generate("append", "/Users/#{username}", [key, "'#{keyword}'"])
					end
				else
					Dscl.generate("create", "/Users/#{username}", [key, "'#{value}'"])
				end
			end
		end

		def self.update(username, password=nil, params=[])
		  base_script(username, password, params)
		  Dscl.run
		end

		def self.create(username, password, params=[])
		  Dscl.generate("create", "/Users/#{username}")
		  Dscl.generate("passwd", "/Users/#{username}", ["'#{password}'"])
		  base_script(username, password, params)
		  Dscl.run
		end

		def self.delete(username)
			Dscl.generate("delete", "/Users/#{username}")
			Dscl.run
		end

		def self.active?(username)
			record = read(username, ["AuthenticationAuthority"])
			!record["dsAttrTypeStandard:AuthenticationAuthority"].include? ";DisabledUser;"
		end

		def self.disable(username)
			params = %w(AuthenticationAuthority ';DisabledUser;')
			Dscl.generate("append", "/Users/#{username}", params)
			Dscl.run
		end

		def self.enable(username)
			response = read(username, ["AuthenticationAuthority"])
			response["dsAttrTypeStandard:AuthenticationAuthority"].delete(";DisabledUser;")
			params = ["dsAttrTypeStandard:AuthenticationAuthority", "'" + response["dsAttrTypeStandard:AuthenticationAuthority"].join(" ") + "'"]
			Dscl.generate("create", "/Users/#{username}", params)
			Dscl.run
		end

		def self.change_password(username, password)
		  Dscl.generate("passwd", "/Users/#{username}", ["'#{password}'"])
		  Dscl.run
		end

	end
end
