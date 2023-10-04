module CesiumIon
  module Tokens
    class Index < CesiumIon::Base

      def process_response response
        response = JSON.parse(response)
        if response.is_a?(Array)
          @response_data = response
        else
          @response_data = response&.with_indifferent_access
        end
      end

      private

      def api_path
        "/tokens"
      end

      def request_type
        'GET'
      end
    end
  end
end
