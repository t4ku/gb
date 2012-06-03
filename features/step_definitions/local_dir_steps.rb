
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
    access_token = args.pop
    access_token.token.should ==  "zxcvbnmasdfghqwert"
    access_token.token_id.should == "12345678"
  end

  @lists = Gb.run("list")
end
