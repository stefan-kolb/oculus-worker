require 'versionomy'

require_relative '../lib/github_repository'

# SCALA
# Source: Github
# Source: Versioneye
# Alt: http://www.scala-lang.org/download/all.html
class Scala
  attr_reader :name, :description

  def initialize
    @name = 'Scala'
    @description = 'The Scala programming language.'

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
    tags = GithubRepository.new('scala', 'scala').tags
    arr = []
    tags.each do |name|
      match = /v([0-9]+\.[0-9]+(\.[0-9]+)?)$/.match(name)
      v, _p = match.captures unless match.nil?
      arr << v unless v.nil?
    end
    arr = arr.compact.uniq
    @versions = arr.collect! { |e| Versionomy.parse(e) }
  end
end
