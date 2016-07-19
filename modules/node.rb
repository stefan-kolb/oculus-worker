require 'excon'

# NODE
# Source: http://semver.io
class Node
  def initialize
    @conn = Excon.new('https://semver.io/')
  end

  def latest_stable
    @conn.get(path: '/node/stable').body
  end

  def latest_unstable
    @conn.get(path: '/node/unstable').body
  end

  def versions
    @conn.get(path: '/node/versions').body.split("\n")
  end
end
