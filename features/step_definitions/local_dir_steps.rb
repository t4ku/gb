Given /^I don't have any config in local dir$/ do File.exists?("~/.gb_profile").should be_false end

When /^I run "gb init --username=(.*?) --password=(.*?)"$/ do |opt1,opt2|
  stub_token = Gb::Token.new
  stub_token.token_id = 12345

  Gb::Token.stub!(:create).and_return(stub_token)
  Gb.run("init","--username","gist-browser-test","--password","gbtest1")
end

Then /^It creates authorization token via github api$/ do
    
end

Then /^The authorization token should be saved to local dir$/ do
  File.exists?("~/.gb_profile").should == true
  profile = File.read("~/.gb_profile")
  profile.should include("config.access_token.token_id = \"12345\"")
end

Given /^I have local profile with authentiocation token$/ do
  File.exists?("~/.gb_profile").should == true
end

When /^I run "gb list"$/ do 
end

Then /^It should fetch gists using authentication token in profile$/ do
  Gb::Gist.should_receive(:list).with do |*args|
    # see env.rb
    access_token = args.shift
    access_token.token.should ==  "zxcvbnmasdfghqwert"
    access_token.token_id.should == "12345678"
  end

  @lists = Gb.run("list")
end


Given /^I have cached response in local dir$/ do
  FileUtils.mkdir("~/.gb")
  FileUtils.mkdir("~/.gb/.cache")
  File.open("~/.gb/.cache/gists.20120610211294.json",'w') do |file|
    file.print FixtureProvider.sample_gists_json
  end
end

Then /^It should fetch gist from local cache$/ do
  stub_io = StringIO.new
  printer = Gb::Printer.get
  printer.io = stub_io

  @lists = Gb.run("list")

  stub_io.seek(0)
  stub_io.read.should include "test entry local"
end

Given /^I don't have local gist repository$/ do
  # nothing to do since @local_profile only creates empty dir
  #
end

When /^I run "gb clone 1234567"$/ do
  @stub_io = StringIO.new
  printer = Gb::Printer.get
  printer.io = @stub_io

  stub_gist = Gb::Gist.new
  stub_gist.git_push_url = "git@github.com:1234567.git"

  Gb::Gist.stub!(:list).and_return([stub_gist])
  Gb.stub(:system).and_return(true)
  Gb.run("clone","1234567")

end

Then /^It should clone gists repository into local dir$/ do
  #Dir.exists?("~/.gb/1234567").should be_true
end

Then /^It should show local path of the repository$/ do
  @stub_io.seek(0)
  @stub_io.read.should include "successfully cloned gist to "
end
