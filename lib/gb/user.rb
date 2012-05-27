require "httparty"
require "json"

module Gb
  class User
    class <<self
      def me
        @me ||=  self.new
      end
    end

    include HTTParty
    base_uri 'https://api.github.com'


    def logged_in?
      return @token != nil
    end

    def create_token(login,pass)
      @token = Token.create('gist-browser-test','gbtest1')
    end
  end
end
