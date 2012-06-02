
Given /^I don't have any config in local dir$/ do
  File.exists?("~/.gb_profile").should be_false
end

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
  profile.should include("config.token_id = \"12345\"")
end

Given /^I have local profile with authentiocation token$/ do
  File.exists?("~/.gb_profile").should == true
end

When /^I run "gb list"$/ do 
end

Then /^It should fetch gists using authentication token in profile$/ do
  Gb::Gist.should_receive(:fetch).with do |args|
    # see env.rb
    config = args.pop
    config.token.should ==  "zxcvbnmasdfghqwert"
    config.token_id.should = "12345678"
  end

  @lists = Gb.run("list")
end

Then /^I should see my gists$/ do
  pending # express the regexp above with the code you wish you had
end

