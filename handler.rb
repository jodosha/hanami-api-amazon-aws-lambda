# frozen_string_literal: true

require_relative "./aws/lambda"
require_relative "./app"

# rubocop:disable Style/GlobalVars
$app ||= App.new

def handler(event:, context:)
  AWS::Lambda.call($app, event, context)
end
# rubocop:enable Style/GlobalVars
