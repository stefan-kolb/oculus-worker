require_relative '../lib/github_repository'

# RUBY
# Source: https://github.com/ruby/ruby
class Ruby
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

  def product
    prod = Product.new(
      # mandatory
      name: 'Ruby',
      language: 'C',
      prod_type: '???no package manager/github?',
      prod_key: '???',

      version: latest_stable,
      description: 'Ruby is the interpreted scripting language for quick and easy object-oriented programming. It has many features to process text files and to do system management tasks (as in Perl). It is simple, straight-forward, and extensible.',
      #licence: 'BSD-2-Clause'
    )

    @versions.each { |v| prod.add_version(v.to_s) }

    prod
  end

  private

  def extract
    tags = GithubRepository.new('ruby', 'ruby').tags
    arr = []
    tags.each do |name|
      match = /^v([0-9]+_[0-9]+_[0-9]+)(_[0-9]{3})?$/.match(name)
      next if match.nil?
      v, p = match.captures
      v = v.tr('_', '.') unless v.nil?
      v = v << p.tr('_', 'p') unless p.nil?
      arr << v
    end
    arr = arr.compact.uniq
    @versions = arr.collect! { |e| Versionomy.parse(e) }
  end
end
