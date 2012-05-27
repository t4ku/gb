module Gb
  class Token
    def self.create(login,pass)
      @auth = { :username => login,:password  => pass  }
      opts = {  :basic_auth => @auth,
                :format => 'json',
                :body => ::JSON.generate({ 
                  :scopes => ["gist"],
                  :note => "gist browser in terminal"
                })
             }
      puts self.class.post('/authorizations',opts)
    end

    attr_accessor :scopes,:created_at,:updated_at,:app,:url,:token,:note,:note_url

    def serialize(res)

    end
  end
end
