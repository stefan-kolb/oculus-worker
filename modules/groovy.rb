require 'json'
require 'rest_client'

# just use versioneye maven
# source: https://www.versioneye.com/api/v2/products/java/org~codehaus~groovy~groovy?api_key=Log+in+to+get+your+own+api+token
# versioneye nicht aktuell!
# http://dist.codehaus.org/groovy/distributions/
# todo caching for faster responses necessary
# semantic versioning: [Y]
# since v2.0.0
# http://groovy.codehaus.org/Version+Scheme?nocache
class Groovy
	def latest_stable
    response = RestClient.get("https://www.versioneye.com/api/v2/products/java/org~codehaus~groovy~groovy?api_key=91780ca596c2e1906a9d")
    data = JSON.parse(response)
    data['version']
	end
	
	def latest_unstable 

	end
	
	def versions

	end
end