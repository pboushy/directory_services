require "plist"

module OpenDirectory
    class Dscl
        @@commands = []

        def self.generate(command, path, params="")
            datasource ||= OpenDirectory.od_datasource
            params = params.join(" ") unless params.empty?
            
            @@commands << "dscl -plist -u #{OpenDirectory.od_username} -P #{OpenDirectory.od_password} #{datasource} -#{command} #{path} #{params}"
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

        def self.run
            response = []
            $ssh ||= Net::SSH.start(OpenDirectory.host_name, OpenDirectory.host_username, :password => OpenDirectory.host_password)
            @@commands.each do |command|
                output = $ssh.exec!(command)
                response << {:parsed_out => parse_output(output), :output => output, :command => command} unless output.nil?
            end
            @@commands.clear
            if response.size == 1
                response[0][:parsed_out]
            else
                response
            end
        end
    end
end
