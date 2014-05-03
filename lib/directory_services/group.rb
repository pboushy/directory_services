module DirectoryServices
	class Group
		def self.all
			DSQuery.generate_dscl("list","/Groups")
			DSQuery.run
		end

		def self.exists?(groupname)
			groups = all
			groups.include?(groupname)
		end

		def self.read(groupname, params="")
			if exists?(username)
				DSQuery.generate_dscl("read", "/Groups/#{groupname}",params)
				DSQuery.run
			else
				false
			end
		end

		def self.find(attribute,value)
			DSQuery.generate_dscl("search","/Groups",[attribute,value])
			DSQuery.run
		end

		def self.get_users_in_group(groupname)
			users = []
			if exists?(groupname)
				params = [
							"GroupMembership",
							"NestedGroups"
						]
				DSQuery.generate_dscl("read","/Groups/#{groupname}",params)
				output = DSQuery.run
				# Add members of group to users array.
				if output.has_key?('dsAttrTypeStandard:GroupMembership')
					users.concat(output['dsAttrTypeStandard:GroupMembership'])
				end
				# if group contains nested groups,
				# get_users_in_group for each nested group and add to users array.
				if output.has_key?('dsAttrTypeStandard:NestedGroups')
					output['dsAttrTypeStandard:NestedGroups'].each do |generate_dscldUID|
						results = find('GeneratedUID',generate_dscldUID)
						if !results.empty?
							result = results[0]
							length_of_nested_group_name = result.index("\t") - "\t".length
							nested_group_name = result.slice(0..length_of_nested_group_name)
							users.concat( get_users_in_group(nested_group_name) )
						end
					end
				end
			end
			users.uniq
		end

		def self.add_users_to_group(groupname, users)
			if exists?(groupname)
				users.each do |user|
					attributes = {
						add_delete: 'add',
						record_type: 'user',
						record_name: user
					}
					DSQuery.generate_deseditgroup("edit","#{groupname}",attributes)
				end
				DSQuery.run
			else
				false
			end
		end

	end
end