require 'aws-sdk-lambda'

# Used in API v1
# TODO: Remove after moving to v2
class LambdaEmailNotificationService
  def initialize(notification, options)
    @notification = notification
    @options = options
  end

  def invoke_lambda
    deliver = @notification.email_deliver
    return unless deliver.is_active

    activity = deliver.activities.create(request_content: @options.to_json, status: 'pending')

    client = Aws::Lambda::Client.new(
      region: 'us-east-1',
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    )

    req_payload = {
      options: @options.to_json,
      smtp:    deliver.smtp_setting.to_json,
      subject: deliver.notification_content.subject,
      content: deliver.notification_content.content
    }

    payload = JSON.generate(req_payload)

    resp = client.invoke({
      function_name: 'notification-center-mail-sender-production-notifier',
      invocation_type: 'RequestResponse',
      log_type: 'None',
      payload: payload
    })

    resp_payload = JSON.parse(resp.payload.string)

    if resp_payload['statusCode'] == 200
      activity.update(status: 'success')
    else
      activity.update(status: 'fail')
    end
  end
end
