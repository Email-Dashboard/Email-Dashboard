class EmailDeliverJob < ApplicationJob
  queue_as :mailer

  def perform(activity_id)
    @activity = Activity.find(activity_id)
    @deliver = @activity.notification_deliver
    return unless %w[pending scheduled].include? @activity.status

    # If notification active and account in live mode send to lambda
    if @deliver.notification.account.live_mode && @deliver.is_active
      process_for_live_mode
    else
      process_for_test_mode
    end
  end

  def process_for_live_mode
    data = JSON.parse(@activity.request_content)

    email_to  = data['email']['to'].is_a?(Array) ? data['email']['to'].join(', ') : data['email']['to']
    email_cc  = data['email']['cc'].is_a?(Array) ? data['email']['cc'].join(', ') : data['email']['cc']
    email_bcc = data['email']['bcc'].is_a?(Array) ? data['email']['bcc'].join(', ') : data['email']['bcc']
    reply_to  = data['email']['reply_to'].is_a?(Array) ? data['email']['reply_to'].join(', ') : data['email']['reply_to']

    # Create activity receivers
    if data['email']['to'].is_a?(Array)
      data['email']['to'].each do |receiver|
        @activity.receivers.create!(email: receiver)
      end
    else
      @activity.receivers.create!(email: email_to)
    end

    deliver_options = {
      email_to: email_to,
      email_from: data['email']['from'],
      cc: email_cc,
      bcc: email_bcc,
      reply_to: reply_to
    }

    invoke_lambda(deliver_options, data['variables'])
  end

  def process_for_test_mode
    if @deliver.is_active
      if @deliver.notification.account.to_email_for_test.present?
        data = JSON.parse(@activity.request_content)

        deliver_options = {
          email_to: @deliver.notification.account.to_email_for_test,
          email_from: data['email']['from']
        }

        invoke_lambda(deliver_options, data['variables'])
        @activity.error_message = "#{@activity.error_message} => Test Mode only to: #{@deliver.notification.account.to_email_for_test}"
        @activity.save
      else
        @activity.update(status: 'canceled', error_message: 'Test Mode Account!')
      end
    else
      @activity.update(status: 'canceled', error_message: 'Notification not active!')
    end
  end

  def invoke_lambda(deliver_options, variables)
    req_payload = {
      options: deliver_options.to_json,
      variables: variables.to_json,
      smtp:    @deliver.smtp_setting.to_json,
      subject: @deliver.notification_content.subject,
      content: @deliver.notification_content.content
    }

    payload = JSON.generate(req_payload)

    service = LambdaEmailNotificationService.new(@activity, payload)
    service.invoke_lambda
  end
end
