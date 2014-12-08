require 'open-uri'

# GO
# Source: https://github.com/golang/go/
class Go
  @versions

  def initialize
    @versions = []
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

  def download page
    response = RestClient.get("https://api.github.com/repos/golang/go/tags?page=#{page}")
    JSON.parse(response)
  end

  def extract
    (1..10).each do |i|
      json = download i

      break if json.empty?

      arr = []
      json.each do |tag|
        match = /go([0-9]+\.[0-9]+(\.[0-9]+)?)$/.match(tag['name'])
        v, p = match.captures unless match.nil?
        arr << v
      end
      arr = arr.compact.uniq
      arr.collect! { |e| Versionomy.parse(e) }
      @versions= @versions + arr
    end
  end
end
