require 'json'
require 'excon'

# GROOVY
# Source: Versioneye
# Alt: http://dist.codehaus.org/groovy/distributions/
# Semantic versioning: [Y]
# Since v2.0.0
# http://groovy.codehaus.org/Version+Scheme
class Groovy
  def latest_stable
    response = Excon.get('https://www.versioneye.com/api/v2/products/java/org~codehaus~groovy:groovy?api_key=91780ca596c2e1906a9d')
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
