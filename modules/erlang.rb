require 'versionomy'

# TODO
# http://www.erlang.org/download/
class Erlang
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
    open('http://www.erlang.org/download/') do |stream|
      stream.read
    end
  end

  def extract
    text = download
    versions = text.scan /otp_src_([0-9]+\.[0-9]+(\.[0-9]+)?)/
    flat = []
    versions.each { |v| flat << v[0] }
    flat = flat.compact.uniq
    @versions = flat.collect! { |e| Versionomy.parse(e) }
  end
end