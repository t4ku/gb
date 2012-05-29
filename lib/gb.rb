require "gb/version"
require "optparse"

require "gb/user"
require "gb/token"
require "gb/local"

module Gb
  class <<self
    def run(*args)

      subcmd = "help"
      options = {}

      commands = {
        'init' => OptionParser.new do |opts|
          subcmd = :init
          opts.on("--username VAL") { |v| options[:username] = v }
          opts.on("--password VAL") { |v| options[:password] = v }
        end,
        'list' => OptionParser.new do |opts|
          prepare_env
        end,
        'config' => OptionParser.new do |opts|
          prepare_env
        end
      }
      commands[args.shift].order!(args)

      case subcmd
        when :init
          token = Token.create(options[:username],options[:password])
          create_profile(token)
      end

    end

    def prepare_env

    end

    def create_profile(token)
      template = <<-EOS
Gb::Configure do |config|
  
  # Token to access gist. created by gb init.
  #
  config.token = "#{token.token}"
  config.token_id = "#{token.token_id}"
end
      EOS
      File.open(File.expand_path('~/.gb_profile'),"w") do |file|
        file.puts template
      end
    end
  end
end
