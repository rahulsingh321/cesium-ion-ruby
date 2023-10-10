require 'cesium_ion/base'
require "cesium_ion/engine"

require 'cesium_ion/base'
require 'cesium_ion/assets/create'
require 'cesium_ion/assets/index'
require 'cesium_ion/assets/show'
require 'cesium_ion/assets/update'
require 'cesium_ion/assets/destroy'

require 'cesium_ion/archives/create'
require 'cesium_ion/archives/index'
require 'cesium_ion/archives/show'
require 'cesium_ion/archives/destroy'

require 'cesium_ion/exports/create'
require 'cesium_ion/exports/index'
require 'cesium_ion/exports/show'

require 'cesium_ion/tokens/create'
require 'cesium_ion/tokens/index'
require 'cesium_ion/tokens/show'
require 'cesium_ion/tokens/destroy'
require 'cesium_ion/tokens/update'


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
