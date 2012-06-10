module Gb
  class Printer
    def self.get
      self.new
    end

    def initialize(output=$stdout)
      @output = output
    end

    def dump(target,template_class,action=nil)
      return unless target

      action = action ? action : :default
      @output.puts template_class.new.send(action,target)
    end
  end

  class TemplatePrinter < Printer
    def dump(target,template)
      return unless target

      if target.respond_to? :each
        target.each do |item|
          @output.puts item.output(self.class)
        end
      else
        @output.puts target.output(self.class)
      end
    end
  end

end
