module CesiumIon
  module Assets
    class Index < CesiumIon::Base

      def process_response response
        @response_data = JSON.parse(response)&.with_indifferent_access
      end

      private

      def api_path
        "/assets"
      end

      def request_type
        'GET'
      end
    end
  end
end
