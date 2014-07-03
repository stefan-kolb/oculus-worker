require 'open-uri'
require 'zlib'

# RUBY
# Source: http://cache.ruby-lang.org/pub/ruby/
# Alt: http://cache.ruby-lang.org/pub/ruby/stable/
class Ruby
  @versions

  def initialize
    extract
  end

  def latest_stable
    @versions.sort.reverse.first
  end

  def latest_unstable
    'Not supported'
  end

  def versions
    @versions.sort.reverse
  end

  private

  def download
    open('http://cache.ruby-lang.org/pub/ruby/') do |stream|
      if (stream.content_encoding.empty?)
        stream.read
      else
        Zlib::GzipReader.new(stream).read
      end
    end
  end

  def extract
    text = download
    versions = text.scan /ruby-([0-9]+\.[0-9]+\.[0-9]+)/i
    flat = versions.inject([]) { |arr, obj| arr << obj[0] }.compact.uniq
    @versions = flat.collect! { |e| Versionomy.parse(e) }
    puts @versions
  end
end