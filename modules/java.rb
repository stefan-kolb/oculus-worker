# JAVA
# Alt: http://en.wikipedia.org/wiki/Java_version_history
class Java
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
    open('http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html', &:read)
  end

  def extract
    text = download
    versions = text.scan /java\sSE\sDevelopment\sKit\s([0-9]+u[0-9]+)/i
    flat = versions.inject([]) { |arr, obj| arr << obj[0] }.compact.uniq
    flat.collect! { |e| '1.' << e.split('u')[0] << '.0_' << e.split('u')[1] }
    @versions = flat.collect! { |e| Versionomy.parse(e) }
  end
end
