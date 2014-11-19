require 'open-uri'

# GO
# Source: http://golang.org/dl/
class Go
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
    open('http://golang.org/dl/') do |stream|
      stream.read
    end
  end

  def extract
    text = download
    versions = text.scan /go([0-9]+\.[0-9]+(\.[0-9]+)?$)/i
    flat = versions.inject([]) { |arr, obj| arr << obj[0] }.compact.uniq
    @versions = flat.collect! { |e| Versionomy.parse(e) }
  end
end