require 'aws-sdk-lambda'

# Used in API v2
class LambdaEmailDeliverJob < ApplicationJob
  queue_as :default

  def perform(params, deliver_id)
    deliver = NotificationDeliver.find(deliver_id)
    data = JSON.parse(params)

    email_to  = data['email']['to'].is_a?(Array) ? data['email']['to'].join(', ') : data['email']['to']
    email_cc  = data['email']['cc'].is_a?(Array) ? data['email']['cc'].join(', ') : data['email']['cc']
    email_bcc = data['email']['bcc'].is_a?(Array) ? data['email']['bcc'].join(', ') : data['email']['bcc']

    # Create Notification Activity
    activity = deliver.activities.create({
      request_content: data['variables'].merge(data['email']).to_json,
      status: 'pending'
    })

    # Create activity receivers
    if data['email']['to'].is_a?(Array)
      data['email']['to'].each do |receiver|
        activity.receivers.create!(email: receiver)
      end
    else
      activity.receivers.create!(email: email_to)
    end

    deliver_options = {
      email_to: email_to,
      email_from: data['email']['from'],
      cc: email_cc,
      bcc: email_bcc
    }

    req_payload = {
      options: deliver_options.to_json,
      variables: data['variables'].to_json,
      smtp:    deliver.smtp_setting.to_json,
      subject: deliver.notification_content.subject,
      content: deliver.notification_content.content
    }

    payload = JSON.generate(req_payload)

    client = Aws::Lambda::Client.new(
      region: 'us-east-1',
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    )

    resp = client.invoke({
      function_name: 'notification-center-mail-sender-v2-prod-notifier',
      invocation_type: 'RequestResponse',
      log_type: 'None',
      payload: payload
    })

    resp_payload = JSON.parse(resp.payload.string)

    if resp_payload['statusCode'] == 200
      activity.update(status: 'success')
    else
      activity.update(status: 'fail', error_message: resp_payload['errorMessage'])
    end
  end
end
