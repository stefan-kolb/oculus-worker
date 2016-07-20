require 'versionomy'

require_relative '../lib/github_repository'

# CLOJURE
# Source: Github
# Maven central: http://central.maven.org/maven2/org/clojure/clojure/
# Source: Versioneye
class Clojure
  attr_reader :name, :description

  def initialize
    @name = 'Clojure'
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
    tags = GithubRepository.new('clojure', 'clojure').tags
    arr = []
    tags.each do |name|
      match = /clojure-([0-9]+\.[0-9]+(\.[0-9]+)?)$/.match(name)
      v, _p = match.captures unless match.nil?
      arr << v unless v.nil?
    end
    arr = arr.compact.uniq
    @versions = arr.collect! { |e| Versionomy.parse(e) }
  end
end
