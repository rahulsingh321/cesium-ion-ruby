module CesiumIon
  module Assets
    class Export < CesiumIon::Base

      Params = Struct.new(
        :inspection_id,
        :site_model_id,
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
          "prefix": "#{Rails.env}/inspection/#{@params.inspection_id}/site_model/#{@params.site_model_id}",
          "accessKeyId": CesiumIon.configuration.access_key_id,
          "secretAccessKey": CesiumIon.configuration.secret_access_key
        }
      end

      def validate
        @errors['site_model_id'] << 'Can\'t be blank' if @params.site_model_id.to_s.empty?
        @errors['inspection_id'] << 'Can\'t be blank' if @params.inspection_id.to_s.empty?
        @errors['asset_id'] << 'Can\'t be blank' if @params.asset_id.to_s.empty?
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
