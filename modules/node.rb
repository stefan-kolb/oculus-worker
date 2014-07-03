require 'rest_client'

# NODE
# Source: http://semver.io
# Alt: http://nodejs.org/dist/
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