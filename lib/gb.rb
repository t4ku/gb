require "gb/version"
require "optparse"

require "gb/user"
require "gb/token"

module Gb
  class <<self
    def run(*args)

      commands = {
        'list' => OptionParser.new do |opts|

          
        end
      }

      commands[args.shift].order!
    end
  end
end
