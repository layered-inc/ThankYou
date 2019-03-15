# frozen_string_literal: true

if Rails.env.production?
  PumaWorkerKiller.config do |config|
    config.ram = Integer(ENV['DYNO_RAM'] || 512) # mb
    config.frequency = 30 # seconds
    config.percent_usage = 0.9
    config.rolling_restart_frequency = 12 * 3600 # 6 hours in seconds
    config.reaper_status_logs = true

    config.pre_term = ->(worker) { puts "Worker #{worker.inspect} being killed" }
  end

  PumaWorkerKiller.start
end
