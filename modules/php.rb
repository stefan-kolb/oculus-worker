# PHP
# Source: http://php.net/downloads.php
# Old: http://php.net/releases/
class Php
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
    'Not supported'
  end

  private

  def download
    open('http://php.net/downloads.php/', &:read)
  end

  def extract
    text = download
    versions = text.scan /php-([0-9]+\.[0-9]+(\.[0-9]+)?)\.tar/i
    flat = versions.inject([]) { |arr, obj| arr << obj[0] }.compact.uniq
    @versions = flat.collect! { |e| Versionomy.parse(e) }
  end
end
