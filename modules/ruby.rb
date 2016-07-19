require_relative '../lib/github_repository'

# RUBY
# Source: https://github.com/ruby/ruby
class Ruby
  @versions

  def initialize
    extract
  end

  def latest_stable
    @versions.sort.reverse.first
  end

  def latest_unstable
    # latest release _previewX or _rcX latest tag
    'Not supported'
  end

  def versions
    @versions.sort.reverse
  end

  private

  def extract
    tags = GithubRepository.new('ruby', 'ruby').tags
    arr = []
    tags.each do |name|
      match = /v([0-9]+.[0-9]+.[0-9]+)(.[0-9]{3}|$)/.match(name)
      v, p = match.captures unless match.nil?
      arr << (v.tr('_', '.') << p.tr('_', 'p') unless p.nil?)
    end
    arr = arr.compact.uniq
    @versions = arr.collect! { |e| Versionomy.parse(e) }
  end
end
