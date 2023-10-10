module CesiumIon
  module Tokens
    class Destroy < CesiumIon::Base
      Params = Struct.new(
        :token_id,
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

      def validate
        @errors['token_id'] << 'Can\'t be blank' if @params.token_id.to_s.empty?
      end

      def api_path
        "/tokens/#{@params.token_id}"
      end

      def endpoint
        'https://api.cesium.com/v2/'.freeze
      end

      def request_type
        'DELETE'
      end
    end
  end
end
