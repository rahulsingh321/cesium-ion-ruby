require "cesium_ion/engine"

require 'cesium_ion/assets/create'
require 'cesium_ion/assets/upload'
require 'cesium_ion/assets/complete'
require 'cesium_ion/assets/export'


module CesiumIon
  class Error < StandardError; end

  class ConfigurationError < CesiumIon::Error
    def message
      'Authorization token must be defined in config'
    end
  end

  class AuthError < CesiumIon::Error
    def message
      'Invalid authorization token'
    end
  end

  class ParameterError < CesiumIon::Error
    def message
      error_hash = JSON.parse(self.to_s.gsub('=>', ':'))
      error_hash.map { |key, value| "#{key} #{value[0]}" }.join(' ')
    end
  end

  class << self
    attr_accessor :configuration

    def configure &blk
      self.configuration ||= CesiumIon::Configuration.new.tap(&blk)
    end
  end

  class Configuration
    attr_accessor :auth_token, :bucket, :access_key_id, :secret_access_key

    def initialize(options={})
      self.auth_token = options['auth_token']
      self.bucket = options['bucket']
      self.access_key_id = options['access_key_id']
      self.secret_access_key = options['secret_access_key']
    end
  end
end

# Alias the module for those looking to use the stylized name CesiumIon
CesiumIon = CesiumIon
