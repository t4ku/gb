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

  context "init" do
    it "should setup profile" do
      Gb::Token.should_receive(:create).and_return(stub_token)

      Gb.run("init","--username","gist-browser-test","--password","gbtest1")
      File.exists?("~/.gb_profile").should == true

      profile = File.read("~/.gb_profile")
      profile.should include("config.token_id = \"12345\"")
    end
  end

  context "list" do
    it "should abord if no profile found" do

    end
  end

end

