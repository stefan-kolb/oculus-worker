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
    response = RestClient.get('https://api.github.com/repos/erlang/otp/tags')
    JSON.parse(response)
  end

  def extract
    json = download
    arr = []
    json.each do |tag|
      match = /OTP-([0-9]+\.[0-9]+(\.[0-9]+)?(\.[0-9]+)?$)/.match(tag['name'])
      v, p = match.captures unless match.nil?
      arr << v unless v.nil?
    end
    arr = arr.compact.uniq
    @versions = arr.collect! { |e| Versionomy.parse(e) }
  end
end
