require 'excon'

# NODE
# Source: http://semver.io
class Node
  attr_reader :name, :description

  def initialize
    @name = Product::A_LANGUAGE_NODEJS #'Node'
    @description = ''
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
