module CesiumIon
  module Tokens
    class Create < CesiumIon::Base

      Params = Struct.new(
        :name,
        :scopes,
        keyword_init: true
      )

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
          "scopes": [
            "assets:read",
            "geocode",
            "profile:read"
          ]
        }

        payload.with_indifferent_access
      end

      def validate
        @errors['scopes'] << 'Can\'t be blank' if @params.scopes.to_s.empty?
        @errors['name'] << 'Can\'t be blank' if @params.name.to_s.empty?
      end

      def api_path
        "/tokens"
      end

      def request_type
        'POST'
      end
    end
  end
end
