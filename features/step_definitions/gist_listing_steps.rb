
When /^I run list command$/ do
  @output = StringIO.new
  Gb::Printer.stub!(:get).and_return(Gb::Printer.new(@output))
  Gb::Gist.stub!(:list).and_return(FixtureProvider.sample_gist_responses)

  Gb.run("list")
end

Then /^I should see my gists$/ do
  @output.seek(0)
  @output.read.should include "test entry"
end

Then /^It is sorted by date$/ do
end
