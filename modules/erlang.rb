require 'versionomy'

require_relative '../lib/github_repository'

# ERLANG
# Source: Github
class Erlang
  attr_reader :name, :description

  def initialize
    @name = 'Erlang'
    @description = 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.' \
    ' OTP is set of Erlang libraries and design principles providing middle-ware to develop these systems.'

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
    tags = GithubRepository.new('erlang', 'otp').tags
    arr = []
    tags.each do |name|
      match = /OTP-([0-9]+\.[0-9]+(\.[0-9]+)?(\.[0-9]+)?$)/.match(name)
      v, _p = match.captures unless match.nil?
      arr << v unless v.nil?
    end
    arr = arr.compact.uniq
    @versions = arr.collect! { |e| Versionomy.parse(e) }
  end
end
