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

require 'cucumber/rspec/doubles'
