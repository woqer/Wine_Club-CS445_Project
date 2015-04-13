# encoding: utf-8
require 'nokogiri'

module DB
  class XML_helper
    @root = File.join("..","..")

    def initialize(obj="subs")
      @path = File.join(@root, "data", obj)
    end

    def search(param, args)
    end

    def reader(id)
    end

    def writer(id)
    end
  end
end
