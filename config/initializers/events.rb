# an event measuring the duration of a job's execution
ActiveSupport::Notifications.subscribe('delayed.job.run') do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  # Emit the event via your preferred metrics/instrumentation provider:
  # tags = event.payload.except(:job).map { |k,v| "#{k.to_s[0..64]}:#{v.to_s[0..255]}" }
  # StatsD.distribution(event.name, event.duration, tags: tags)

  # puts "COMING FROM ACTIVE SUPPORT NOTIFS. THIS IS THE DELAYED.JOB.RUN EVENT: #{event.name} #{event.children} #{event.duration} #{event.payload} #{event.transation_id}"


  # return event.payload[:value]
end

# an event indicating that a job has permanently failed or has errored and may be retried (no duration attached)
ActiveSupport::Notifications.subscribe(/delayed\.job\.(error|failure)/) do |*args|
  # ...
  # Statsd.increment(...)
end

class DelayedJobCount

  # def self.get_job_count
  #   # this event on the total number of jobs. 
  #   ActiveSupport::Notifications.subscribe('delayed.job.count') do |*args|
  #     event = ActiveSupport::Notifications::Event.new(*args)
  #     # value = event.payload.delete(:value)

  #     # Emit the event via your preferred metrics/instrumentation provider:
  #     # tags = event.payload.map { |k,v| "#{k.to_s[0..64]}:#{v.to_s[0..255]}" }
  #     # StatsD.gauge(event.name, value, sample_rate: 1.0, tags: tags)
  #     if event.payload[:priority] == "user_visible"
  #       puts "COMING FROM ACTIVE SUPPORT NOTIFS. THIS IS THE DELAYED.JOB.COUNT EVENT: I think this is the number of job active #{event.payload[:value]}"

  #       return event.name
  #     end
  #   end
  # end

end
