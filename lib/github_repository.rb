require 'json'
require 'octokit'

class GithubRepository

  def initialize(owner, repository)
    @repo = "#{owner}/#{repository}"

    # fetches all paginated entries
    Octokit.auto_paginate = true
    #@client = Octokit::Client.new :access_token => ENV['MY_PERSONAL_TOKEN']
    @client = Octokit::Client.new
  end

  def tags
    tags = Octokit.tags(@repo)
    tags.collect { |tag| tag.name }
  end
end