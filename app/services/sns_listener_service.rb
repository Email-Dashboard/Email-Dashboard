class SnsListenerService
  def self.sns_message notification_hash

    message = Hashie::Mash.new notification_hash
    case message.Type
    when "SubscriptionConfirmation"
      confirm_subscription(message.TopicArn, message.Token)
    when "Notification"
      notification(message.Message)
    else
      raise "Unknown notification type #{notification.Type}"
    end
  end

  def self.notification raw_message
    message = Hashie::Mash.new(JSON.parse(raw_message))
    if message.notificationType == 'AmazonSnsSubscriptionSucceeded'
      return
    else
      sns_notification_handler(message)
    end
  end

  def self.confirm_subscription(arn, token)
    sns = Aws::SNS::Client.new(region: 'us-east-1', credentials: Aws::Credentials.new('AKIAJZPCJQTLJIK3F2XA', 'km6Dkz/zfpFirjuFifGvictYZ4AG1mGZBAoh7Eye'))

    resp = sns.confirm_subscription({
      topic_arn: arn,
      token: token
    })
  end

  def self.sns_notification_handler(message)
    activity = Activity.find_by(message_header_id: message.mail.commonHeaders.messageId)
    activity.update(track_status: message.notificationType.downcase)
  end
end