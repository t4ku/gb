module Gb
  module Local
    class Base
      def exists?
        File.exists?(@path)
      end

      def init
        unless exists?

        end
      end
    end

    class Cache < Base
      def initialize(path)
        @path = path
      end

      def profile
        @profile ||=  Profile.new("#{@path}/.profile")
      end

    end

    class Profile < Base

    end

    class Store < Base

    end

    class Repo < Base

    end

  end
end
