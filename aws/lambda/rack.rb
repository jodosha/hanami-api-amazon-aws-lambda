# frozen_string_literal: true

require "stringio"
require "rack"
require "base64"

module AWS
  module Lambda
    # Adapted from https://github.com/aws-samples/serverless-sinatra-sample/blob/master/lambda.rb
    #
    # rubocop:disable Metrics/MethodLength
    module Rack
      def self.env_for(event)
        headers = event.fetch("headers", {})
        body = body_for(event)

        env = {
          "REQUEST_METHOD" => event.fetch("httpMethod", "GET"),
          "SCRIPT_NAME" => "",
          "PATH_INFO" => event.fetch("path", "/"),
          "QUERY_STRING" => ::Rack::Utils.build_query(event["queryStringParameters"] || {}),
          "SERVER_NAME" => headers.fetch("Host", "localhost"),
          "SERVER_PORT" => headers.fetch("X-Forwarded-Port", 443).to_s,

          "rack.version" => ::Rack::VERSION,
          "rack.url_scheme" => headers.fetch("CloudFront-Forwarded-Proto") { headers.fetch("X-Forwarded-Proto", "https") },
          "rack.input" => StringIO.new(body),
          "rack.errors" => $stderr
        }

        merge_headers!(headers, env)
      end

      def self.success(response)
        {
          statusCode: response[0],
          headers: response[1],
          body: response[2].map(&:to_s).join
        }
      end

      def self.failure(exception)
        {
          statusCode: 500,
          body: exception.message
        }
      end

      def self.body_for(event)
        # Check if the body is base64 encoded. If it is, try to decode it
        if event["isBase64Encoded"]
          Base64.decode64(event["body"])
        else
          event["body"]
        end || ""
      end

      # Code from https://github.com/aws-samples/serverless-sinatra-sample/blob/master/lambda.rb
      def self.merge_headers!(headers, env)
        headers.each do |key, value|
          # "CloudFront-Forwarded-Proto" => "CLOUDFRONT_FORWARDED_PROTO"
          # Content-Type and Content-Length are handled specially per the Rack SPEC linked above.
          name = key.upcase.gsub "-", "_"
          header = case name
                   when "CONTENT_TYPE", "CONTENT_LENGTH"
                     name
                   else
                     "HTTP_#{name}"
                   end

          env[header] = value.to_s
        end

        env
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end