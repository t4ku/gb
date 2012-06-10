require "spec_helper"

module Gb
  describe Printer do
    context "List Gists" do
      it "should show title" do
        output = StringIO.new
        printer = Printer.new(output)
        
        gist = Gist.new
        gist.gist_id = 1234567
        gist.description = "test title"

        printer.dump([gist],Gb::Template::GistList)

        output.seek(0)
        output.read.should == "1234567 test title\n"
      end
    end
  end
end
