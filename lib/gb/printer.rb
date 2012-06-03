module Gb
  class Printer
    def self.get
      self.new
    end

    def initialize(output=$stdout)
      @output = output
    end

    def dump(target)
      if target.respond_to? :each
      else
        @output.puts target.output
      end
    end
  end
end
