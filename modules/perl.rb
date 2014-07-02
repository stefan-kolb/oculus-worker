require 'versionomy'

# TODO
#Version scheme
#Perl has used the following policy since the 5.6 release of Perl:
# Maintenance branches (ready for production use) are even numbers (5.8, 5.10, 5.12 etc)
# Sub-branches of maintenance releases (5.12.1, 5.12.2 etc) are mostly just for bug fixes
# Development branches are odd numbers (5.9, 5.11, 5.13 etc)
# RC (release candidates) leading up to a maintenance branch are called testing release
class Perl
  @versions
  @stable
  @unstable

  def initialize
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

  def download
    open('http://www.cpan.org/src/README.html') do |stream|
      stream.read
    end
  end

  def extract
    text = download
    versions = text.scan /perl-([0-9]+\.[0-9]+(\.[0-9]+)?)/
    flat = []
    versions.each { |v| flat << v[0] }
    flat = flat.compact.uniq

    @stable = flat.find_all { |e| /^[0-9]+\.\d*[02468](\.[0-9]+)?$/ =~ e }
    @unstable = flat.find_all { |e| /^[0-9]+\.\d*[13579](\.[0-9]+)?$/ =~ e }

    @stable.collect! { |e| Versionomy.parse(e) }
    @unstable.collect! { |e| Versionomy.parse(e) }
    @versions = flat.collect! { |e| Versionomy.parse(e) }
  end
end