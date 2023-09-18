module CesiumIon
  class Config
    CONFIG_KEYS = [ :auth_token, :access_key_id, :secret_access_key, :bucket]

    class << self
      attr_accessor *CONFIG_KEYS

      def configure(config)
        config.stringify_keys!
        @auth_token = config['auth_token']
        @access_key_id = config['access_key_id']
        @client_secret = config['client_secret']
        @bucket = config['bucket']

        self
      end
    end
  end
end
