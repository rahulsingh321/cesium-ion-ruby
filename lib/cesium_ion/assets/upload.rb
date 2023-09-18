require 'aws-sdk-core'
require 'aws-sdk-s3'

module CesiumIon
  module Assets
    class Upload < CesiumIon::Base

      Params = Struct.new(
        :response_data,
        :input_file,
        keyword_init: true
      )

      def initialize params={}
        super()
        @params = Params.new(params)
      end

      # Check parameters presence
      def process_request
        validate
        raise CesiumIon::ParameterError, @errors unless valid?

        # Creating Aws object
        s3 = Aws::S3::Resource.new(
          region: 'us-east-1',
          endpoint: location[:endpoint],
          credentials: Aws::Credentials.new(
            location[:accessKey],
            location[:secretAccessKey],
            location[:sessionToken]
          )
        )

        # Opening the obj file
        file = File.open(@params.input_file)

        bucket = s3.bucket(location[:bucket])
        s3_object = bucket.object("#{location[:prefix]}" + file.filename)

        # Uploading the file on S3
        s3_object.upload_file(file)

        file.close
      end

      private

      def validate
        @errors['response_data'] << 'Can\'t be blank' if @params.response_data.to_s.empty?
        @errors['input_file'] << 'Can\'t be blank' if @params.input_file.to_s.empty?
      end

      def location
        @params.response_data.with_indifferent_access[:uploadLocation]
      end
    end
  end
end
