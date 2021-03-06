require 'open-uri'

# PYTHON
# Source: https://www.python.org/download/
class Python
  attr_reader :name, :description

  def initialize
    @name = 'Python'
    @description = 'The Python programming language.'

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
    open('https://www.python.org/download/', &:read)
  end

  def extract
    text = download
    versions = text.scan(/python-([0-9]+\.[0-9]+(\.[0-9]+)?)\.tar/i)
    flat = versions.inject([]) { |arr, obj| arr << obj[0] }.compact.uniq
    @versions = flat.collect! { |e| Versionomy.parse(e) }
  end
end
