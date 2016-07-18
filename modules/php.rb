# PHP
# Source: https://github.com/php/php-src
class Php
  @versions

  def initialize
    extract
  end

  def latest_stable
    # TODO: there are three stable versions 5.5, 5.6, 7.x
    @versions.sort.reverse.first
  end

  def latest_unstable
    'Not supported'
  end

  def versions
    'Not supported'
  end

  private

  def download
    response = RestClient.get('https://api.github.com/repos/php/php-src/tags')
    JSON.parse(response)
  end

  def extract
    json = download
    arr = []
    json.each do |tag|
      match = /^php-([0-9]+\.[0-9]+(\.[0-9]+)?$)/.match(tag['name'])
      v, p = match.captures unless match.nil?
      arr << v unless v.nil?
    end
    @versions = arr.collect! { |e| Versionomy.parse(e) }
  end
end
