require 'aws-sdk-lambda'

class LambdaEmailNotificationService
  def initialize(notification, options)
    @notification = notification
    @options = options
  end

  def invoke_lambda
    deliver = @notification.email_deliver
    return unless deliver.is_active

    client = Aws::Lambda::Client.new(
      region: 'us-east-1',
      credentials: Aws::Credentials.new('AKIAJN5IGRLH4PBQW4QQ', 'wed2RlMYlu/+kHU8KZWvBJgVRNSEulZQAp3H6NNS')
    )

    req_payload = {
      from_email: @options[:from_email],
      reply_to: @options[:reply_to],
      content: deliver.notification_content.content
    }

    payload = JSON.generate(req_payload)

    resp = client.invoke({
      function_name: 'email-notifier-lambda',
      invocation_type: 'RequestResponse',
      log_type: 'None',
      payload: payload
    })

    resp_payload = JSON.parse(resp.payload.string)
    puts resp_payload
  end
end
