require 'open-uri'

# JAVA
# Alt: http://en.wikipedia.org/wiki/Java_version_history
class Java
  attr_reader :name, :description

  def initialize
    @name = 'Java'
    @description = 'The Java programming language.'

    extract
  end

  def latest_stable
    @versions.sort.reverse.first
  end

  def latest_unstable
    'Not supported'
  end

  # not supported
  def versions
    []
  end

  private

  def download
    open('http://www.oracle.com/technetwork/java/javase/downloads/jdk10-downloads-4416644.html', &:read)
  end

  def extract
    text = download
    versions = text.scan(/java\sSE\sDevelopment\sKit\s([0-9]+.[0-9]+.[0-9]+)/i)
    flat = versions.inject([]) { |arr, obj| arr << obj[0] }.compact.uniq
    @versions = flat.collect! { |e| Versionomy.parse(e) }
  end
end
