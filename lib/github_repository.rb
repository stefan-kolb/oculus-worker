require 'octokit'

class GithubRepository
  def initialize(owner, repository)
    @repo = "#{owner}/#{repository}"

    # fetches all paginated entries
    Octokit.auto_paginate = true
    # use auth for higher rate limits ( 60/h vs 5000/h)
    # see https://developer.github.com/v3/#rate-limiting
    @client = if ENV['GITHUB_ACCESS_TOKEN']
                Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
              else
                Octokit::Client.new
              end
  end

  def tags
    tags = @client.tags(@repo)
    tags.collect(&:name)
  end
end
