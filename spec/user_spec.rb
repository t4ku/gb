require "spec_helper"

module Gb
  describe User do
    context "Model" do
      it "should setup object from json response" do
        user = User.new

        user = user.deserialize(
           {
             "gravatar_id" => "e437a5764f68dcabf9b8d86653866c16",
             "login"       => "gist-browser-test",
             "avatar_url"  => "https://secure.gravatar.com/avatar/e437a5764f68dcabf9b8d86653866c16?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
             "url"         => "https://api.github.com/users/gist-browser-test",
             "id"          => 1782474
        })

        user.gravatar_id.should == "e437a5764f68dcabf9b8d86653866c16"
        user.login.should       == "gist-browser-test"
        user.avatar_url.should  == "https://secure.gravatar.com/avatar/e437a5764f68dcabf9b8d86653866c16?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png"
        user.url.should         == "https://api.github.com/users/gist-browser-test"
        user.user_id.should     == 1782474

      end
    end
  end
end

