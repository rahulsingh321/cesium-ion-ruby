module CesiumIon
  module Archives
    class Create < CesiumIon::Base

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

      def payload
        payload = {
        "format": "ZIP"
        }

        payload.with_indifferent_access
      end

      def validate
        @errors['asset_id'] << 'Can\'t be blank' if @params.asset_id.to_s.empty?
      end

      def api_path
        "/assets/#{@params.asset_id}/archives"
      end

      def request_type
        'POST'
      end
    end
  end
end
