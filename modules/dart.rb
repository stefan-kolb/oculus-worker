# DART
class Dart
  attr_reader :name, :description

  def initialize
    @name = 'Dart'
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
    tags = GithubRepository.new('dart-lang', 'sdk').tags
    arr = []
    tags.each do |name|
      match = /^([0-9]+\.[0-9]+(\.[0-9]+)?$)/.match(name)
      v, _p = match.captures unless match.nil?
      arr << v unless v.nil?
    end
    @versions = arr.collect! { |e| Versionomy.parse(e) }
  end
end
