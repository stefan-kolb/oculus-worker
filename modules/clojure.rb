require 'json'
require 'rest_client'

# TODO
# maybe maven central: http://central.maven.org/maven2/org/clojure/clojure/
class Clojure
	def latest_stable
    response = RestClient.get("https://www.versioneye.com/api/v2/products/java/org~clojure~clojure?api_key=91780ca596c2e1906a9d")
    data = JSON.parse(response)
    data['version']
  end
	
	def latest_unstable 

	end
	
	def versions

  end

end