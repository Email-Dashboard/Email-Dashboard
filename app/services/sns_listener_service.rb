class SnsListenerService
  def self.sns_message(notification_hash, aid = nil)

    message = Hashie::Mash.new notification_hash
    case message.Type
    when "SubscriptionConfirmation"
      account = Account.find aid
      confirm_subscription(message.TopicArn, message.Token, account)
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

  def self.confirm_subscription(arn, token, account)
    sns = Aws::SNS::Client.new(region: 'us-east-1', credentials: Aws::Credentials.new(account.sns_access_key, account.sns_secret_key))

    resp = sns.confirm_subscription({
      topic_arn: arn,
      token: token
    })
  end

  def self.sns_notification_handler(message)
    activity = Activity.find_by(message_header_id: message.mail.commonHeaders.messageId)
    activity.update(track_status: message.notificationType.downcase) if activity.present?
  end
end