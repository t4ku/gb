require "spec_helper"

module Gb
  describe Gist do
    before(:each) do
      @token = Token.new
      @token.token = "zxcvbnm"
    end

    def gist_json
      json = [
        {
           "html_url"=>"https://gist.github.com/2862339",
           "public"=>true,
           "files"=>{
             "test_entry.txt"=>{
               "type"     => "text/plain",
               "language" => "Text",
               "raw_url"  => "https://gist.github.com/raw/2862339/956b9047aeba44ea280a493da259b382a2a40825/test_entry.txt",
               "size"     => 8,
               "filename" => "test_entry.txt"
             }
           },
           "user"=>{
             "gravatar_id" => "e437a5764f68dcabf9b8d86653866c16",
             "login"       => "gist-browser-test",
             "avatar_url"  => "https://secure.gravatar.com/avatar/e437a5764f68dcabf9b8d86653866c16?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
             "url"         => "https://api.github.com/users/gist-browser-test",
             "id"          => 1782474
           }, 
           "description"  => "test entry",
           "created_at"   => "2012-06-03T07:00:47Z",
           "url"          => "https://api.github.com/gists/2862339",
           "updated_at"   => "2012-06-03T07:03:07Z",
           "git_pull_url" => "git://gist.github.com/2862339.git",
           "comments"     => 0,
           "git_push_url" => "git@gist.github.com:2862339.git",
           "id"           => "2862339"
        }
      ]
      response = double("response")
      response.stub(:parsed_response) { json }
      response.stub(:code) { 200 }
      response
    end

    it "should request gists api with access token in profile" do
      HTTParty.should_receive(:get)
              .with { |*args|
                url = args.shift
                url.should end_with "access_token=zxcvbnm"
              }.and_return(gist_json)

      gists = Gist.list(@token)
      gists.size.should == 1

      gist = gists.first

      gist.html_url.should   == "https://gist.github.com/2862339"
      gist.public.should     == true
      gist.files.size.should == 1

      gist.user.login.should == "gist-browser-test"
      # gist.user.avatar_id.should == "https://secure.gravatar.com/avatar/e437a5764f68dcabf9b8d86653866c16?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png"
      # gist.user.url.should == "https://api.github.com/users/gist-browser-test"
      # gist.user.user_id.should == 1782474

      gist.description.should  == "test entry"
      gist.created_at.should   == "2012-06-03T07:00:47Z"
      gist.url.should          == "https://api.github.com/gists/2862339"
      gist.updated_at.should   == "2012-06-03T07:03:07Z"
      gist.git_pull_url.should == "git://gist.github.com/2862339.git"
      gist.comments.should     == 0
      gist.git_push_url.should == "git@gist.github.com:2862339.git"
      gist.gist_id             == "2862339"

    end

     it "should test" do
       token = Token.new
       token.token = "504b081786d695a54d499cd2edacf6349694086f"
       res =  Gist.list(token)
     end

  end
end
