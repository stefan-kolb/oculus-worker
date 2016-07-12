# PYTHON
# Source: https://www.python.org/download/
class Python
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
    open('https://www.python.org/download/', &:read)
  end

  def extract
    text = download
    versions = text.scan /python-([0-9]+\.[0-9]+(\.[0-9]+)?)\.tar/i
    flat = versions.inject([]) { |arr, obj| arr << obj[0] }.compact.uniq
    @versions = flat.collect! { |e| Versionomy.parse(e) }
  end
end
