module Gb
  class Token
    def self.create(login,pass)
      @auth = { :username => login,:password  => pass  }
      opts = {  :basic_auth => @auth,
                :format => :json,
                :body => ::JSON.generate({ 
                  :scopes => ["gist"],
                  :note => "gist browser in terminal"
                })
             }
      resp = HTTParty.post("#{GIST_BASE_URL}/authorizations",opts)
      handle_response(resp)
    end

    def self.handle_response(response)
      case response.code
        when 400..500
          raise RequestError,response.parsed_response["message"]
      end

      if response.parsed_response
        self.new.serialize(response.parsed_response)
      end
    end

    attr_accessor :scopes,:created_at,:updated_at,:app,:url,:token,:note,:note_url,:token_id

    def serialize(res)
      @scopes = res["scopes"]
      @created_at = res["created_at"]
      @updated_at = res["updated_at"]
      @url = res["url"]
      @token = res["token"]
      @note  = res["note"]
      @note_url  = res["note_url"]
      @token_id = res["id"]

      return self
    end

    def to_param_with_key
      "access_token=#{@token}"
    end
  end
end
