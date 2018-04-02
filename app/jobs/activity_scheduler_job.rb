require 'sidekiq-scheduler'

class ActivitySchedulerJob < ApplicationJob
  queue_as :default

  def perform
    Activity.where(status: ['pending', 'scheduled']).each do |activity|
      Rails.logger.info "Activty runned: #{Time.current}"
      LambdaEmailDeliverJob.perform_async(activity.id)
    end
  end
end
