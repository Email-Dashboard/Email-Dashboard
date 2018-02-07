class EnqueueEmailJob < ApplicationJob
  queue_as :default

  def perform(args)
    data = JSON.parse(args)

    if data['delivery'].present? && data['delivery']['time'].present? &&
        data['delivery']['date'].present?

      time_zone = data['delivery']['time_zone'] || 'UTC'
      zone = ActiveSupport::TimeZone.all.collect(&:name).includes?(time_zone) ? time_zone : 'UTC'

      # ActiveSupport::TimeZone[zone].parse("2018-02-07 21:00:00").utc
      send_at = ActiveSupport::TimeZone[zone].parse("#{data['delivery']['date']} #{data['delivery']['time']}").utc

      LambdaEmailDeliverJob.perform_at(data, args)
    else
      LambdaEmailDeliverJob.perform_async(data)
    end
  end
end
