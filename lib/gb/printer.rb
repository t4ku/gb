module Gb
  class Printer
    attr_accessor :io

    def self.get
      @printer ||= self.new
    end

    def initialize(output=$stdout)
      @io = output
    end

    def dump(target,template_class,action=nil)
      return unless target

      action = action ? action : :default
      @io.puts template_class.new.send(action,target)
    end
  end

end
