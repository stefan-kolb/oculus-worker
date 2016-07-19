require 'json'
require 'octokit'

class GithubRepository

  def initialize(owner, repository)
    @repo = "#{owner}/#{repository}"

    # fetches all paginated entries
    Octokit.auto_paginate = true
    # use auth for higher rate limits ( 60/h vs 5000/h)
    # see https://developer.github.com/v3/#rate-limiting
    if ENV['GITHUB_ACCESS_TOKEN']
      @client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
    else
      @client = Octokit::Client.new
    end
  end

  def tags
    tags = Octokit.tags(@repo)
    tags.collect { |tag| tag.name }
  end
end