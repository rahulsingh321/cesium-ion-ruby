module CesiumIon
  module Archives
    class Show < CesiumIon::Base
      Params = Struct.new(
        :asset_id,
        :archive_id,
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
        @errors['asset_id'] << 'Can\'t be blank' if @params.asset_id.to_s.empty?
        @errors['archive_id'] << 'Can\'t be blank' if @params.archive_id.to_s.empty?
      end

      def api_path
        "/assets/#{@params.asset_id}/archives/#{@params.archive_id}"
      end

      def request_type
        'GET'
      end

    end
  end
end
