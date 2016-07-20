require 'hitimes'
require 'mongoid'
require 'require_all'

require 'versioneye-core'
require 'versioneye/models/language'
require 'versioneye/models/product'
require 'versioneye/log'

require_relative 'config/openssl'

require_all 'modules'

Mongoid.load!('config/mongoid.yml')

class Crawler
  def logger
    if !defined?(@log) || @log.nil?
      @log = Versioneye::DynLog.new('log/oculus.log', 10).log
    end
    @log
  end

  def all
    logger.info 'Processing complete crawl...'
    timer = Hitimes::TimedMetric.new('full-crawl')

    Dir['modules/*.rb'].each do |file|
      timer.measure do
        file_name = File.basename(file, '.rb')
        @parser = file_name.camelcase.constantize.new
        crawl file_name
      end
    end

    logger.info 'Finished complete crawl!'
    logger.info "Processing time was #{timer.sum}."
    logger.info "Min: #{timer.min}, Max: #{timer.max}, Mean: #{timer.mean}."
  end

  private

  def crawl(ware)
    create_or_update_language
    create_or_update_product

  rescue Timeout::Error, Errno::ETIMEDOUT, Errno::ECONNREFUSED
    diff_in_seconds = (DateTime.now - package.updated_at) * 1.days unless package.updated_at.blank?
    # a week threshold
    over_threshold = diff_in_seconds.nil? || diff_in_seconds > 604_800

    logger.error "Timeout Threshold! Error package #{package}" if over_threshold
  rescue Exception => e
    logger.error "Caught #{e.class}"
    logger.error "Error package #{ware}"
    logger.error e.message
    logger.error e.backtrace.inspect
    # TODO: send mail, works over logentries atm
  end

  def create_or_update_product
    product = Product.find_or_create_by(language: @parser.name, prod_key: @parser.name.downcase)

    product.name = @parser.name
    product.name_downcase = @parser.name.downcase
    product.language = @parser.name
    product.prod_key = @parser.name.downcase
    product.prod_key_dc = @parser.name.downcase
    product.prod_type = 'Oculus'
    product.description = @parser.description

    version = @parser.latest_stable
    raise "Empty version result for #{@parser.class.name}!" if version.blank?
    logger.info "#{@parser.name}: Latest version #{version}"
    product.version = version
    @parser.versions.each { |v| product.add_version(v.to_s) }

    # TODO: do I need to create notifications on my own?
    # CrawlerUtils.create_newest( product, package['version'], self.logger )
    # CrawlerUtils.create_notifications( product, package['version'], self.logger )

    product.save
  end

  def create_or_update_language
    language = Language.find_or_create_by(name: @parser.name)
    language.stable_version = @parser.latest_stable
    language.save
  end
end
