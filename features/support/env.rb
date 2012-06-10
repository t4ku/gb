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
  config.local_path = "~/.gb"
  
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

    def sample_gists_json
      json =<<EOS
[
  {
    "user":
    {
      "login":"gist-browser-test",
      "avatar_url":"https://secure.gravatar.com/avatar/e437a5764f68dcabf9b8d86653866c16?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
      "gravatar_id":"e437a5764f68dcabf9b8d86653866c16",
      "url":"https://api.github.com/users/gist-browser-test",
      "id":1782474
    },
    "created_at":"2012-06-03T07:00:47Z",
    "files":
    {
      "test_entry_local.txt":
      {
        "raw_url":"https://gist.github.com/raw/2862339/956b9047aeba44ea280a493da259b382a2a40825/test_entry.txt",
        "type":"text/plain",
        "language":"Text",
        "size":8,
        "filename":"test_entry_local.txt"
      }
    },
    "description":"test entry local",
    "public":true,
    "comments":0,
    "git_pull_url":"git://gist.github.com/2862339.git",
    "updated_at":"2012-06-03T07:03:07Z",
    "html_url":"https://gist.github.com/2862339",
    "git_push_url":"git@gist.github.com:2862339.git",
    "id":"2862339",
    "url":"https://api.github.com/gists/2862339"
    }
]
EOS
      json
    end
  end
end

require 'cucumber/rspec/doubles'
