require 'rufus/scheduler'

require_relative 'crawler'

# always flush stdout for reliable logging
$stdout.sync = true

scheduler = Rufus::Scheduler.new

# once a day 7 am
scheduler.cron '0 7 * * *' do
  Crawler.new.all
end

scheduler.join
