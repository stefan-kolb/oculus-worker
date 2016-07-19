require 'versionomy'

require_relative '../lib/github_repository'

# PHP
# Source: https://github.com/php/php-src
class Php
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

  def extract
    tags = GithubRepository.new('php', 'php-src').tags
    arr = []
    tags.each do |name|
      match = /^php-([0-9]+\.[0-9]+(\.[0-9]+)?$)/.match(name)
      v, _p = match.captures unless match.nil?
      arr << v unless v.nil?
    end
    @versions = arr.collect! { |e| Versionomy.parse(e) }
  end
end
