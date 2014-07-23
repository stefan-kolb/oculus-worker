require 'json'
require 'rest_client'

# SCALA
# Source: Versioneye
# Alt: http://www.scala-lang.org/download/all.html
class Scala
	def latest_stable
    response = RestClient.get("https://www.versioneye.com/api/v2/products/java/org~scala-lang:scala-library?api_key=91780ca596c2e1906a9d")
    data = JSON.parse(response)
    data['version']
	end

  def latest_unstable
    'Not supported'
  end

  def versions
    'Not supported'
  end
end