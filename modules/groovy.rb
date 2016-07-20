require 'json'
require 'excon'

# GROOVY
# Source: Versioneye
# Semantic versioning: [Y]
# Since v2.0.0
# http://groovy.codehaus.org/Version+Scheme
class Groovy
  attr_reader :name, :description

  def initialize
    @name = 'Groovy'
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

  def extract
    tags = GithubRepository.new('apache', 'groovy').tags
    arr = []
    tags.each do |name|
      match = /GROOVY_([0-9]+_[0-9]+(_[0-9]+)?)$/.match(name)
      v, _p = match.captures unless match.nil?
      arr << v.tr('_', '.') unless v.nil?
    end
    arr = arr.compact.uniq
    @versions = arr.collect! { |e| Versionomy.parse(e) }
  end
end
