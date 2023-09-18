module CesiumIon
  module Assets
    class Create < CesiumIon::Base

      Params = Struct.new(
        :center_coordinates,
        :height,
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
          "name": "3D-Tile",
          "description": "File to convert to 3d",
          "type": "3DTILES",
          "options": {
            "sourceType": "3D_CAPTURE",
            "geometryCompression": "NONE"
          }
        }
        if false #@params.center_coordinates
          payload[:options]["position"] = [
            @params.center_coordinates[:lng],
            @params.center_coordinates[:lat],
            @params.height
          ]
        end

        payload
      end

      def api_path
        '/assets'
      end

      def request_type
        'POST'
      end
    end
  end
end
