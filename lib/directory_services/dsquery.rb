require "plist"
require "open3"

module DirectoryServices
	class DSQuery
		@@commands = []

		# operation: edit, checkmember
		# attributes: {:add_delete => 'add'|'delete', :record_type => 'user'|'group', :record_name => 'group_name'|'user_name'}
		def self.generate_dseditgroup(operation, groupname, attributes)
			datasource ||= DirectoryServices.od_datasource
			command = "dseditgroup -o #{operation} -n #{datasource} -u '#{DirectoryServices.od_username}' -P '#{DirectoryServices.od_password}' "
			command << case operation
			when 'edit'
				if (attributes[:add_delete] == 'add' || attributes[:add_delete] == 'delete') && 
					!attributes[:record_name].empty? && 
					(attributes[:record_type] == 'user' || attributes[:record_type] == 'group')
				then
					if attributes[:add_delete] == 'delete'
						"-d #{attributes[:record_name]} -t #{attributes[:record_type]} #{groupname}"
					else
						"-a #{attributes[:record_name]} -t #{attributes[:record_type]} #{groupname}"
					end
				end
			when 'checkmember'
				"-m #{record_name} #{groupname}"
			else
			end
			@@commands << command
		end
		def self.generate_dscl(operation, path, params="")
			datasource ||= DirectoryServices.od_datasource
			params = params.join(" ") unless params.empty?
			
			@@commands << "dscl -plist -u '#{DirectoryServices.od_username}' -P '#{DirectoryServices.od_password}' #{datasource} -#{operation} #{path} #{params}"
		end

		def self.parse_output(string)
			begin
				parsed_xml = Plist::parse_xml( string )
				if parsed_xml.nil?
					string.split("\n")
				else
					parsed_xml
				end
			rescue RuntimeError => e
				string.split("\n")
			rescue TypeError => e
				if e.nil?
					""
				else
					e.to_s
				end
			end
		end

		def self.run(debug=false)
			response = []
			if DirectoryServices.run_locally == 'yes'
				@@commands.each do |command|
					output, error, status = Open3.capture3(command)
					response << {:parsed_out => parse_output(output), :output => output, :command => command} unless output.nil?
				end
			else
				$ssh ||= Net::SSH.start(DirectoryServices.host_name, DirectoryServices.host_username, :password => DirectoryServices.host_password)
				@@commands.each do |command|
					output = $ssh.exec!(command)
					response << {:parsed_out => parse_output(output), :output => output, :command => command} unless output.nil?
				end
			end
			@@commands.clear
			if response.size == 1 && debug == false
				response[0][:parsed_out]
			else
				response
			end
		end
	end
end
