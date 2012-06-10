require "gb/version"
require "optparse"
require "erb"

require "gb/user"
require "gb/token"
require "gb/config"
require "gb/gist"
require "gb/template"
require "gb/printer"

module Gb
  GIST_BASE_URL='https://api.github.com'
  class <<self
    def run(*args)

      subcmd = args.shift
      options = {}

      commands = {
        'init' => OptionParser.new do |opts|
          opts.on("--username VAL") { |v| options[:username] = v }
          opts.on("--password VAL") { |v| options[:password] = v }
        end,
        'list' => OptionParser.new do |opts|
        end
      }
    
      commands[subcmd].order!(args)
    
      case subcmd
        when "init"
          puts "creating token..."
          token = Token.create(options[:username],options[:password])
          create_profile(token)
        when "list"
          config = load_profile
          if config && config.local_path
            FileUtils.mkdir(config.local_path) unless File.exist?(config.local_path)
            FileUtils.mkdir(config.cache_path) unless File.exist?(config.cache_path)

            gists = Gist.list(config.access_token,:cache_path => config.cache_path)
            printer = Gb::Printer.get
            printer.dump(gists,Gb::Template::GistList)
          else
            raise "Invalid Profile"
          end
      end

    end

    def config
      @config ||= Config.new
    end

    def configure
      yield config
      config
    end

    private

    def create_profile(token)
      template = <<-EOS
Gb::configure do |config|
  config.local_path = "~/.gb"
  
  # Token to access gist. created by gb init.
  #
  config.access_token.token = "#{token.token}"
  config.access_token.token_id = "#{token.token_id}"
end
      EOS
      File.open(File.expand_path('~/.gb_profile'),"w") do |file|
        file.puts template
      end
    end

    def load_profile
      ret = nil
      File.open(File.expand_path('~/.gb_profile')) do |file|
        ret = instance_eval(file.read)
      end
    end
  end
end
