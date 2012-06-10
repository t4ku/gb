module Gb
  class Gist
    class RequestError < Exception;end

    # dirty stub for
    # HTTParty::Response Class
    #

    class LocalResponse
      def code
        200
      end

      def initialize(body)
        @json = body
      end

      def parsed_response
        MultiJson.load(@json)
      end
    end

    # Class Methods
    # 

    class << self
      def list(token=nil,opts={})
        resp = get_local(token,opts)
        unless resp
          resp = get_remote(token,opts)
        end
        handle_response(resp)
      end

      def get_remote(token=nil,opts={})
        opts = {
          :format => :json
        }
        resp = HTTParty.get("#{GIST_BASE_URL}/gists?#{token.to_param_with_key if token}",opts)
      end

      def get_local(token=nil,opts={})
        return unless opts[:cache_path]

        path = File.expand_path(opts[:cache_path])
        hit =  Dir.glob("#{path}/gists.*.json").first
        json_cache = File.read(hit)
        return LocalResponse.new(json_cache)
      end

      def handle_response(response)
        case response.code
          when 400..500
            raise RequestError,response.parsed_response["message"]
        end

        gists = []

        if response.parsed_response
          response.parsed_response.each do |res|
            gists << self.new.deserialize(res)
          end
        end

        gists
      end

    end

    attr_accessor :html_url,:public,:files,:user,
                :description,:created_at,:url,:updated_at,
                :git_pull_url,:comments,:git_push_url,:gist_id

    # Methods

    def deserialize(res)
      @html_url    = res["html_url"]
      @public      = res["public"]
      @files       = res["files"]
      @description = res["description"]
      @created_at  = res["created_at"]
      @url         = res["url"]
      @updated_at  = res["updated_at"]

      @user = User.new.deserialize(res["user"])

      @git_pull_url = res["git_pull_url"]
      @comments     = res["comments"]
      @git_push_url = res["git_push_url"]
      @gist_id      = res["id"]

      self
    end

    def output
      "#{gist_id} #{description}"
    end
  end
end
