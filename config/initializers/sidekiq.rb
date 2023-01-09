# frozen_string_literal: true

ActiveJob::Base.queue_adapter = :sidekiq
require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq-scheduler'
require 'sidekiq-scheduler/web'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('../sidekiq_scheduler.yml', __dir__))
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username),
                                              ::Digest::SHA256.hexdigest('test')) &
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password),
                                                ::Digest::SHA256.hexdigest('test'))
end
