module Gb
  class Config
    def self.load

    end

    attr_accessor :local_path
    def access_token
      @token ||= Token.new
    end
    def cache_path
      "#{local_path}/.cache"
    end
  end
end
