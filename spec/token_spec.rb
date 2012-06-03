require "spec_helper"

def auth_response
  body =  { 
     "scopes"     => ["gist"],
     "updated_at" => "2012-05-27T10:21:19Z",
     "app"=>{
       "url"  => "http://developer.github.com/v3/oauth/#oauth-authorizations-api",
       "name" => "gist browser in terminal (API)"
     },
     "url"        => "https://api.github.com/authorizations/380446",
     "token"      => "f73609e429b15119cb0d7feb46f70bb470615aaf",
     "note"       => "gist browser in terminal",
     "note_url"   => "abc",
     "created_at" => "2012-05-27T10:21:19Z",
     "id"         => 380446
  }
  response = double("response")
  response.stub(:parsed_response){ body }
  response.stub(:code) { 200 }
  response
end

module Gb
  describe Token do
    context "API call" do
      it "should post github authorization api" do
        HTTParty.should_receive(:post).and_return(auth_response)

        token = Token.create('gist-browser-test','gbtest1')

        token.scopes.should     == ["gist"]
        token.created_at.should == "2012-05-27T10:21:19Z"
        token.url.should        == "https://api.github.com/authorizations/380446"
        token.token.should      == "f73609e429b15119cb0d7feb46f70bb470615aaf"
        token.note.should       == "gist browser in terminal"
        token.note_url.should   == "abc"
        token.token_id.should   == 380446
      end
    end

    context "Model" do
      it "should return url parameter to be used for api call" do
        token = Token.new
        token.token = "zxcvbnm"

        token.to_param_with_key.should == "access_token=zxcvbnm"
      end
    end
  end
end
