require 'aws-sdk-lambda'

# Used in API v1
# TODO: Remove after moving to v2
class LambdaEmailNotificationService
  def initialize(activity, payload)
    @activity = activity
    @payload = payload
  end

  def invoke_lambda
    client = Aws::Lambda::Client.new(
      region: 'us-east-1',
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    )

    begin
      resp = client.invoke({
        function_name: 'notification-center-mail-sender-v2-prod-notifier',
        invocation_type: 'RequestResponse',
        log_type: 'None',
        payload: @payload
      })

      response = JSON.parse(resp.payload.string)

      if response['statusCode'] == 200
        @activity.update(status: 'success')
      else
        @activity.update(status: 'fail', error_message: (response['errorMessage'].presence || response['body']))
      end
    rescue => e
      @activity.update(status: 'fail', error_message: e)
    end
  end
end
