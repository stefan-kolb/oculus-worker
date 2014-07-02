require 'open-uri'
require 'zlib'
# source: http://cache.ruby-lang.org/pub/ruby/
# stable http://cache.ruby-lang.org/pub/ruby/stable/
# todo caching, does this algo work everytime...
class Ruby
  @versions

  def initialize
    extract
  end

  def latest_stable
    @versions.sort.reverse.first
  end

  def latest_unstable

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
    versions = text.scan /[0-9]+\.[0-9]+\.[0-9]+/
    flat = versions.uniq
    @versions = flat.collect! { |e| Versionomy.parse(e) }
  end
end