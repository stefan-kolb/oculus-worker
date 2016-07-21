require 'versionomy'

require_relative '../lib/github_repository'

# PERL
# Source: Github
# Version scheme:
# Perl has used the following policy since the 5.6 release of Perl:
# Maintenance branches (ready for production use) are even numbers (5.8, 5.10, 5.12 etc)
# Sub-branches of maintenance releases (5.12.1, 5.12.2 etc) are mostly just for bug fixes
# Development branches are odd numbers (5.9, 5.11, 5.13 etc)
# RC (release candidates) leading up to a maintenance branch are called testing release
class Perl
  attr_reader :name, :description

  def initialize
    @name = 'Perl'
    @description = 'The Perl 5 language interpreter.'

    extract
  end

  def latest_stable
    @stable.sort.reverse.first
  end

  def latest_unstable
    @unstable.sort.reverse.first
  end

  def versions
    @versions.sort.reverse
  end

  private

  def extract
    tags = GithubRepository.new('perl', 'perl5').tags
    arr = []
    tags.each do |name|
      # no RC candidates
      match = /^v([0-9]+\.[0-9]+(\.[0-9]+)?)$/.match(name)
      v, _p = match.captures unless match.nil?
      arr << v unless v.nil?
    end
    flat = arr.compact.uniq

    @stable = flat.find_all { |e| /^[0-9]+\.\d*[02468](\.[0-9]+)?$/ =~ e }
    @unstable = flat.find_all { |e| /^[0-9]+\.\d*[13579](\.[0-9]+)?$/ =~ e }

    @stable.collect! { |e| Versionomy.parse(e) }
    @unstable.collect! { |e| Versionomy.parse(e) }
    @versions = flat.collect! { |e| Versionomy.parse(e) }
  end
end
