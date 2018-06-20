require 'aws-sdk-lambda'

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

      if resp_payload['statusCode'] == 200
        @activity.update(status: 'success', message_header_id: response['body']['messageId'], track_status: 'sent')
      else
        @activity.update(status: 'fail', error_message: (resp_payload['errorMessage'].presence || resp_payload['body']))
      end
    rescue => e
      @activity.update(status: 'fail', error_message: e)
    end
  end
end
