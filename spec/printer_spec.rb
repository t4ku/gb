require "spec_helper"

module Gb
  describe Printer do
      it "should show title" do
        output = StringIO.new
        printer = Printer.new(output)
        
        gist = Gist.new
        gist.gist_id = 1234567
        gist.description = "test title"

        printer.dump([gist],Gb::Template::GistList)

        output.seek(0)
        output.read.should include  " test title\n"
      end

      it "should no description when description is empty" do
        output = StringIO.new
        printer = Printer.new(output)

        gist = Gist.new
        gist.gist_id = 1234567
        gist.description = ""

        printer.dump([gist],Gb::Template::GistList)

        output.seek(0)
        output.read.should include "(no description)\n"
      end
  end
end
