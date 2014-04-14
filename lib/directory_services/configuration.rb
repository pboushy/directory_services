module DirectoryServices
    module Configuration
        VALID_OPTIONS_KEYS    = %w(host_name host_username host_password od_username od_password od_datasource).freeze

        HOST_NAME = nil
        HOST_USERNAME = nil
        HOST_PASSWORD = nil
        OD_USERNAME = nil
        OD_PASSWORD = nil
        OD_DATASOURCE = '/LDAPv3/127.0.0.1/'

        attr_accessor *VALID_OPTIONS_KEYS

        def self.extended(base)
            base.reset
        end

        def reset
            self.host_name = HOST_NAME
            self.host_username = HOST_USERNAME
            self.host_password = HOST_PASSWORD
            self.od_username = OD_USERNAME
            self.od_password = OD_PASSWORD
            self.od_datasource = OD_DATASOURCE
        end

        def configure
            yield self
        end
    end
end
