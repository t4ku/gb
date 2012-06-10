require "gb"
require "fakefs/safe"

Before do
  FakeFS.activate!
  FakeFS::FileSystem.clone(File.expand_path(File.dirname(__FILE__))).inspect
end

After do
  FakeFS::FileSystem.clear
  FakeFS.deactivate!
end

Before('@local_profile') do
  profile = <<-EOS
Gb::configure do |config|
  config.cache_path = "~/.gb"
  
  # Token to access gist. created by gb init.
  #
  config.access_token.token = "zxcvbnmasdfghqwert"
  config.access_token.token_id = "12345678"
end
EOS

	File.open('~/.gb_profile','w') do |file|
		file.puts profile
	end
end

module FixtureProvider
  class <<self
    def sample_gist_responses

      gist = Gb::Gist.new
      gist.html_url   = "https://gist.github.com/2862339"
      gist.public     = true

      gist.description  = "test entry"
      gist.created_at   = "2012-06-03T07:00:47Z"
      gist.url          = "https://api.github.com/gists/2862339"
      gist.updated_at   = "2012-06-03T07:03:07Z"
      gist.git_pull_url = "git://gist.github.com/2862339.git"
      gist.comments     = 0
      gist.git_push_url = "git@gist.github.com:2862339.git"
      gist.gist_id             = "2862339"

      [gist]
    end
  end
end

require 'cucumber/rspec/doubles'
