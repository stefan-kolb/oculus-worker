require 'rest-client'

# NODE
# Source: http://semver.io
class Node
  attr_reader :name, :description

  def initialize
    @name = 'Node'
    @description = 'Node.js is a JavaScript runtime built on Chrome\'s V8 JavaScript engine.'
  end

  def latest_stable
    RestClient.get('https://semver.io/node/stable')
  end

  def latest_unstable
    RestClient.get( 'https://semver.io/node/unstable')
  end

  def versions
    RestClient.get( 'https://semver.io/node/versions').split("\n")
  end
end
