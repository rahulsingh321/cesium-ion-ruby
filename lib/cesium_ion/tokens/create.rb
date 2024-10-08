module CesiumIon
  module Tokens
    class Create < CesiumIon::Base

      Params = Struct.new(
        :name,
        :scopes,
        keyword_init: true
      )

      ALLOWED_SCOPES = ["assets:list","assets:write", "profile:read", "tokens:read", "tokens:write", "archives:read", "archives:write", "exports:read", "exports:write"]

      def initialize params={}
        super()
        @params = Params.new(params)
      end

      def process_response response
        @response_data = JSON.parse(response)&.with_indifferent_access
      end

      private

      def payload
        payload = {
          "name": @params.name,
          "scopes": @params.scopes
        }

        payload.with_indifferent_access
      end

      def validate
        @errors['scopes'] << 'Can\'t be blank' if @params.scopes.to_s.empty?
        @errors['name'] << 'Can\'t be blank' if @params.name.to_s.empty?
        @errors['scopes'] << 'Invaid scopes Provided' unless valid_scopes_parameter(@params.scopes)
      end

      def valid_scopes_parameter(scopes)
        valid = false

        scopes.each do |scope|
          if ALLOWED_SCOPES.include?(scope)
            valid = true
          else
            valid = false
            break
          end
        end
        valid
      end

      def api_path
        "/tokens"
      end

      def endpoint
        'https://api.cesium.com/v2/'.freeze
      end

      def request_type
        'POST'
      end
    end
  end
end
