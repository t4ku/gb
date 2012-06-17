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
      subargs = {}

      commands = {
        'init' => OptionParser.new do |opts|
          opts.on("--username VAL") { |v| options[:username] = v }
          opts.on("--password VAL") { |v| options[:password] = v }
        end,
        'list' => OptionParser.new do |opts|
        end,
        'clone' => OptionParser.new do |opts|
          opts.on("VAL") { |v| subargs[:clone_id] = v }
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
            # TODO: remove redunduncy
            FileUtils.mkdir(File.expand_path(config.local_path)) unless File.exist?(File.expand_path(config.local_path))
            FileUtils.mkdir(File.expand_path(config.cache_path)) unless File.exist?(File.expand_path(config.cache_path))

            gists = Gist.list(config.access_token,:cache_path => config.cache_path)
            printer = Gb::Printer.get
            printer.dump(gists,Gb::Template::GistList)
          else
            raise "Invalid Profile"
          end
        when "clone"
          unless subargs.has_key?(:clone_id) && subargs[:clone_id].size > 6
            raise "invalid gist id"
          end

          config = load_profile
          if config && config.local_path
            printer = Gb::Printer.get
            gists = Gist.list(config.access_token,:cache_path => config.cache_path)

            gist = gists.select { |elm| elm.gist_id = subargs[:clone_id] }.first
            if system("cd #{config.local_path};git clone #{gist.git_push_url}")
              printer.io.puts "successfully cloned gist to #{config.local_path}/#{gist.gist_id}"
            else
              printer.io.puts "error:#{$?}"
            end
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
