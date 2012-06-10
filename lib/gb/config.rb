module Gb
  class Config
    def self.load

    end

    attr_accessor :cache_path
    def access_token
      @token ||= Token.new
    end
  end
end
