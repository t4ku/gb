require "spec_helper"

module Gb
  describe User do
    context "without authentication" do
      it "should know" do
        User.me.logged_in?.should be_false
      end

    end
  end
end
