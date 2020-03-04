# frozen_string_literal: true

module AWS
  module Lambda
    require_relative "./lambda/rack"

    def self.call(app, event, _context) # rubocop:disable Metrics/MethodLength
      response = {}

      begin
        response = success(
          app.call(
            env_for(event)
          )
        )
      rescue => exception # rubocop:disable Style/RescueStandardError
        response = failure(exception)
      end

      response
    end

    def self.env_for(event)
      Rack.env_for(event)
    end

    def self.success(response)
      Rack.success(response)
    end

    def self.failure(exception)
      Rack.failure(exception)
    end
  end
end
