require 'json'
require 'excon'

# CLOJURE
# Maven central: http://central.maven.org/maven2/org/clojure/clojure/
# Source: Versioneye
class Clojure
  def latest_stable
    response = Excon.get('https://www.versioneye.com/api/v2/products/java/org~clojure:clojure?api_key=91780ca596c2e1906a9d')
    data = JSON.parse(response.body)
    data['version']
  end

  def latest_unstable
    'Not supported'
  end

  def versions
    'Not supported'
  end
end
