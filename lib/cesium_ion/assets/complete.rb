module CesiumIon
  module Assets
    class Complete < CesiumIon::Base
      ASSET_STATUS = 'COMPLETED'

      Params = Struct.new(
        :response_data,
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
        @errors['response_data'] << 'Can\'t be blank' if @params.response_data.to_s.empty?
      end

      def endpoint
        @params.response_data.with_indifferent_access.dig(:onComplete, :url)
      end

      def api_path
        ""
      end

      def request_type
        'POST'
      end
    end
  end
end
