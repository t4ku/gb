require "httparty"
require "json"

module Gb
  class User
    # class <<self
    #   def me
    #     @me ||=  self.new
    #   end
    # end

    # include HTTParty
    # base_uri 'https://api.github.com'


    # def logged_in?
    #   return @token != nil
    # end

    # def create_token(login,pass)
    #   @token = Token.create('gist-browser-test','gbtest1')
    # end

    attr_reader :gravatar_id,:login,:avatar_url,:url,:user_id

    def deserialize(res)
      @login       = res["login"]
      @gravatar_id = res["gravatar_id"]
      @avatar_url  = res["avatar_url"]
      @url         = res["url"]
      @user_id     = res["id"]
      self
    end
  end
end
