require 'rest_client'

# just use http://semver.io
# source: http://nodejs.org/dist/
# todo caching for faster responses necessary
class Node
	def latest_stable
		RestClient.get('https://semver.io/node/stable')
	end
	
	def latest_unstable 
		RestClient.get('https://semver.io/node/unstable')
	end
	
	def versions
		RestClient.get('https://semver.io/node/versions').split("\n")
	end
end