module CesiumIon
  module Archives
    class Index < CesiumIon::Base
      Params = Struct.new(
        :asset_id,
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

      def api_path
        "/assets/#{@params.asset_id}/archives"
      end

      def request_type
        'GET'
      end
    end
  end
end
