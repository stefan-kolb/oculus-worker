require 'open-uri'
require 'zlib'

# RUBY
# Source: https://github.com/ruby/ruby
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
    response = RestClient.get('https://api.github.com/repos/ruby/ruby/tags')
    JSON.parse(response)
  end

  def extract
    json = download
    arr = []
    json.each do |tag|
      match = /v([0-9]+.[0-9]+.[0-9]+)(.[0-9]{3}|$)/.match(tag['name'])
      v, p = match.captures unless match.nil?
      arr << (v.tr('_', '.') << p.tr('_', 'p') unless p.nil?)
    end
    arr = arr.compact.uniq
    @versions = arr.collect! { |e| Versionomy.parse(e) }
  end
end
