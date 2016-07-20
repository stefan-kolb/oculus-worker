require 'open-uri'
require 'versionomy'

# LUA
# Source: http://www.lua.org/ftp/
class Lua
  attr_reader :name, :description

  def initialize
    @name = 'Lua'
    @description = ''

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
    open('http://www.lua.org/ftp/', &:read)
  end

  def extract
    text = download
    versions = text.scan(/lua-([0-9]+\.[0-9]+(\.[0-9]+)?)/i)
    flat = versions.inject([]) { |arr, obj| arr << obj[0] }.compact.uniq
    @versions = flat.collect! { |e| Versionomy.parse(e) }
  end
end
