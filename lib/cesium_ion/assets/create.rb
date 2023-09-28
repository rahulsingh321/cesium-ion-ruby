module CesiumIon
  module Assets
    class Create < CesiumIon::Base

      Params = Struct.new(
        :name,
        :type,
        :description,
        :attribution,
        :source_type,
        :options,
        keyword_init: true
      )

      ALLOWED_PARAMETERS = {
        'RASTER_IMAGERY' => [],
        'RASTER_TERRAIN' => ['heightReference', 'toMeters', 'baseTerrainId', 'waterMask'],
        'TERRAIN_DATABASE' => [],
        'CITYGML' => ['geometryCompression', 'disableColors', 'disableTextures', 'clampToTerrain', 'baseTerrainId'],
        'KML' => ['geometryCompression', 'baseTerrainId'],
        '3D_CAPTURE' => ['position', 'geometryCompression', 'textureFormat'],
        '3D_MODEL' => ['position', 'geometryCompression', 'textureFormat', 'optimize'],
        'POINT_CLOUD' => ['position', 'geometryCompression'],
        '3DTILES' => ['tilesetJson'],
        'CZML' => [],
        'GEOJSON' => []
      }

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
          "name": @params.name.to_s,
          "type": @params.type.to_s,
          "description": @params.description.to_s,
          "options": @params.options
        }

        payload.with_indifferent_access
      end

      def validate
        @errors['name'] << 'Can\'t be blank' if @params.name.to_s.empty?
        @errors['type'] << 'Can\'t be blank' if @params.type.to_s.empty?
        @errors['source_type'] << 'Can\'t be blank' if @params.options.with_indifferent_access.dig(:sourceType).to_s.empty?
        @errors['options'] << 'Invaid options parameter' unless valid_options_parameter(payload)
      end

      def valid_options_parameter(payload)
        source_type = payload.dig('options','sourceType')
        valid = false

        if ALLOWED_PARAMETERS.key?(source_type)
          user_parameters = payload['options'].keys
          user_parameters = user_parameters - ['sourceType']
          allowed_parameters = ALLOWED_PARAMETERS[source_type]

          valid = true if (user_parameters - allowed_parameters).empty?
        end

        valid
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
