module CesiumIon
  module Exports
    class Create < CesiumIon::Base
      Params = Struct.new(
        :prefix,
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
        {
          "type": "S3",
          "bucket": CesiumIon.configuration.bucket,
          "prefix": @params.prefix,
          "accessKeyId": CesiumIon.configuration.access_key_id,
          "secretAccessKey": CesiumIon.configuration.secret_access_key
        }
      end

      def validate
        @errors['asset_id'] << 'Can\'t be blank' if @params.asset_id.to_s.empty?
        @errors['prefix'] << 'Can\'t be blank' if @params.prefix.to_s.empty?
      end

      def api_path
        "/assets/#{@params.asset_id}/exports"
      end

      def request_type
        'POST'
      end
    end
  end
end