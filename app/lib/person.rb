# encoding: utf-8
require File.join(File.dirname(__FILE__), "bad_arg_error.rb")

class Person
  attr_reader :name
  def initialize(name="")
    @name = name
    check_name
  end

  def check_name
    if @name.length < 1    
      raise BadArgError, "Bad address, #{k} not valid"
    end
  end
end
