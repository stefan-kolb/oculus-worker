require 'date'
require 'mongoid'
require 'require_all'

require 'versioneye-core'
require 'versioneye/models/language'

require_relative 'config/openssl'

require_all 'modules'

Mongoid.load!('config/mongoid.yml')

class Crawler
  @parser

  def all
    puts 'Processing complete crawl...'
    start = Time.new

    Dir['modules/*.rb'].each do |file|
      file_name = File.basename(file, '.rb')
      @parser = file_name.camelcase.constantize.new
      crawl file_name
    end

    stop = Time.new
    time = stop - start
    puts 'Finished complete crawl!'
    puts "Processing time was #{time}."
  end

  private

  def crawl(ware)
    result = @parser.latest_stable

    if result.blank?
      raise "Empty version result for #{result.class.name}!"
    else
      package = Language.where(name: ware)

      if package.exists?
        Language.create(
          name: ware,
          stable_version: result
          # latest_version
          # revision: DateTime.now
        )
      else
        package.update(
          stable_version: result
          #revision: DateTime.now
        )
      end
    end

  rescue Timeout::Error, Errno::ETIMEDOUT, Errno::ECONNREFUSED
    diff_in_seconds = (DateTime.now - package.revision) * 1.days unless package.revision.blank?
    # a week threshold
    over_threshold = diff_in_seconds.nil? || diff_in_seconds > 604_800

    puts "Timeout Threshold! Error package #{package}" if over_threshold
  rescue Exception => e
    puts "Caught #{e.class}"
    puts "Error package #{ware}"
    puts e.message
    puts e.backtrace.inspect
    # TODO: send mail, works over logentries atm
  end
end
