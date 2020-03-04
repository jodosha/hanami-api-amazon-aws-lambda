# frozen_string_literal: true

require_relative "./aws/lambda"
require_relative "./app"
require "logger"

# rubocop:disable Style/GlobalVars
$app ||= App.new
$logger ||= Logger.new($stdout)

def handler(event:, context:)
  # Useful for debugging:
  #
  # $logger.info(event)
  # $logger.info(AWS::Lambda::Rack.env_for(event))

  AWS::Lambda.call($app, event, context)
end
# rubocop:enable Style/GlobalVars
