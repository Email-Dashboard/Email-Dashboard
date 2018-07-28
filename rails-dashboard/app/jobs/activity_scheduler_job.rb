require 'sidekiq-scheduler'

class ActivitySchedulerJob < ApplicationJob
  queue_as :default

  def perform
    Activity.where(status: ['pending', 'scheduled']).where('send_at < ?', Time.current).each do |activity|
      Sidekiq.logger.info "Activty run in: #{Time.current}, for activity send_at: #{activity.send_at}"
      EmailDeliverJob.perform_later(activity.id)
    end
  end
end
