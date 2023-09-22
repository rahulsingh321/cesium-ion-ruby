module CesiumIon
  module Assets
    class Create < CesiumIon::Base

      Params = Struct.new(
        :name,
        :type,
        :description,
        :source_type,
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
          "name": @params.name.to_s,
          "type": @params.type.to_s,
          "description": @params.description.to_s,
          "options": {
            "sourceType": @params.source_type,
          }
        }

        payload
      end

      def validate
        @errors['name'] << 'Can\'t be blank' if @params.name.to_s.empty?
        @errors['type'] << 'Can\'t be blank' if @params.type.to_s.empty?
        @errors['source_type'] << 'Can\'t be blank' if @params.source_type.to_s.empty?
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
