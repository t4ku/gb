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

require 'cucumber/rspec/doubles'
