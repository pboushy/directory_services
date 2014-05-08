module DirectoryServices
	module Configuration
		VALID_OPTIONS_KEYS = %w(run_locally host_name host_username host_password od_username od_password od_datasource).freeze
		attr_accessor *VALID_OPTIONS_KEYS

		def load_env
			self.run_locally = ENV["RUN_LOCALLY"] || 'yes'
			self.host_name = ENV["HOST_NAME"]
			self.host_username = ENV["HOST_USERNAME"]
			self.host_password = ENV["HOST_PASSWORD"]
			self.od_username = ENV["OD_USERNAME"]
			self.od_password = ENV["OD_PASSWORD"]
			self.od_datasource = ENV["OD_DATASOURCE"] || '/LDAPv3/127.0.0.1'
			return "success."
		end

		def configure
			yield self
		end
	end
end
