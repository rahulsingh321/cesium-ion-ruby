module CesiumIon
  class Base
    attr_reader :response_data, :response_status, :authorization_token, :site_model

    def initialize
      @authorization_token = CesiumIon.configuration&.auth_token
      @bucket = CesiumIon.configuration&.bucket
      @access_key_id = CesiumIon.configuration&.access_key_id
      @secret_access_key = CesiumIon.configuration&.secret_access_key

      raise CesiumIon::ConfigurationError if !valid_for_execution

      @errors = Hash.new {|h,k| h[k] = Array.new }
    end

    def set_auth_header(request)
      if requires_authentication?
        CesiumIon.generate_token if CesiumIon.configuration.auth_token.to_s.empty?
        request["Authorization"] = CesiumIon.configuration.auth_token
      end
    end

    def is_form_request?
      false
    end

    def response
      execute
      self
    end

    def errors
      @errors ||= {}
    end

    def valid?
      errors.empty?
    end

    def request path, request_type, &blck
      url = endpoint + path
      url = URI(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      case request_type
        when 'GET'
          request = Net::HTTP::Get.new(url)
        when 'POST'
          request = Net::HTTP::Post.new(url)
        when 'PUT'
          request = Net::HTTP::Patch.new(url)
        when 'DELETE'
          request = Net::HTTP::Delete.new(url)
        else
          raise 'Invalid request type'
      end

      set_auth_header(request)
      if is_form_request?
        request["content-type"] = 'application/x-www-form-urlencoded'
      else
        request["content-type"] = 'application/json'
      end
      yield(http, request)
    end

    def execute
      validate
      raise CesiumIon::ParameterError, @errors unless valid?
      make_request
    end

    def validate
    end

    def make_request
      request(api_path, request_type) do |http, request|
        request.body = parse_payload if payload.any?
        process_request http, request
      end
    end

    def process_request http, request
      response = http.request(request)
      @response_status = response.code.to_i

      raise CesiumIon::AuthError if @response_status == 401

      if response.is_a?(Net::HTTPSuccess)
        process_response(response.body) if response.body
      else
        error_message = "#{response.error_type&.to_s} #{JSON.parse(response.body)&.with_indifferent_access.dig(:message)}"
        raise StandardError, error_message
      end
    end

    def request_type
      raise 'Define request type in base class'
    end

    def api_path
      raise 'Define api path of API in base class'
    end

    def parse_payload
      if is_form_request?
        return URI.encode_www_form(payload)
      else
        return payload.to_json
      end
    end

    def requires_authentication?
      true
    end

    private

    def payload
      {}
    end

    def valid_for_execution
      @authorization_token.to_s.present?
    end

    def update_cesium_asset_status!
      cesium_asset = site_model.cesium_asset
      cesium_asset.update(status: self.class::ASSET_STATUS, failure_reason: nil)
    end

    def endpoint
      'https://api.cesium.com/v1'.freeze
    end
  end
end