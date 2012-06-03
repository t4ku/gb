module Gb
  class Config
    def self.load

    end

    def access_token
      @token ||= Token.new
    end
  end
end
