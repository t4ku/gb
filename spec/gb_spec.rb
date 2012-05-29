require "spec_helper"
require "fakefs/safe"

describe Gb do
  before(:each) do
    FakeFS.activate!
    FakeFS::FileSystem.clone(File.expand_path(File.dirname(__FILE__))).inspect
  end

  after(:each) do
    FakeFS::FileSystem.clear
    FakeFS.deactivate!
  end

  def stub_token
    token = Gb::Token.new
    token.token_id = 12345
    token
  end

  context "list" do
    it "should abord if no profile found" do

    end
  end

end

