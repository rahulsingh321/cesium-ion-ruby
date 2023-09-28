module CesiumIon
  module Assets
    class Update < CesiumIon::Base
      Params = Struct.new(
        :name,
        :description,
        :attribution,
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

      def validate
        if @params.name.to_s.empty? && @params.description.to_s.empty? && @params.attribution.to_s.empty?
          @errors['parameters'] << 'Can\'t be blank please include either name, attribution and description'
        end
      end

      def payload
        payload = {
          "name": @params.name.to_s,
          "description": @params.description.to_s,
          "attribution": @params.attribution.to_s
        }

        payload.with_indifferent_access
      end

      def api_path
        "/assets/#{@params.asset_id}"
      end

      def request_type
        'PUT'
      end
    end
  end
end
