require 'json'
require 'rest-client'

class GithubRepository

  def initialize(name)
    @name = name
    @api_url = "https://api.github.com/repos/#{name}"
  end

  def tags
    response = RestClient.get("#{@api_url}/tags")
    json = JSON.parse(response)
    json.collect { |entry| entry['name'] }
  end
end