require 'versionomy'

# ERLANG
# Source: http://www.erlang.org/download/
class Erlang
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
    open('http://www.erlang.org/download/') do |stream|
      stream.read
    end
  end

  def extract
    text = download
    versions = text.scan /otp_src_([0-9]+\.[0-9]+(\.[0-9]+)?)\.tar\.gz/i
    flat = versions.inject([]) { |arr, obj| arr << obj[0] }.compact.uniq
    @versions = flat.collect! { |e| Versionomy.parse(e) }
  end
end