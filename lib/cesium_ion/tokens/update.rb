module CesiumIon
  module Tokens
    class Update < CesiumIon::Base
      Params = Struct.new(
        :token_id,
        :name,
        :scopes,
        :asset_ids,
        :allowed_urls,
        keyword_init: true
      )

      ALLOWED_SCOPES = ["assets:list","assets:write", "profile:read", "tokens:read", "tokens:write", "archives:read", "archives:write", "exports:read", "exports:write"]

      def initialize params={}
        super()
        @params = Params.new(params)
      end

      def process_response response
        @response_data = JSON.parse(response)&.with_indifferent_access
      end

      private

      def validate
        if @params.token_id.to_s.empty? && @params.asset_ids.empty? && @params.scopes.empty? &&  @params.asset_ids.empty? && @params.allowed_urls
          @erros['No parameter provided'] << "Atleast provide one of the following parameter for updating the token"
        end

        @errors['scopes'] << 'Invaid scopes Provided' unless valid_scopes_parameter(@params.scopes)
      end

      def valid_scopes_parameter(scopes)
        valid = false

        scopes.each do |scope|
          if ALLOWED_SCOPES.include?(scope)
            valid = true
          else
            valid = false
            break
          end
        end
        valid
      end

      def payload
        {
          "name": @params.name.to_s,
          "assetIds": @params.asset_ids,
          "scopes": @params.scopes,
          "allowedUrls": @params.allowed_urls
        }
      end

      def api_path
        "/tokens/#{@params.token_id}"
      end

      def endpoint
        'https://api.cesium.com/v2/'.freeze
      end

      def request_type
        'PUT'
      end
    end
  end
end
