# encoding: utf-8

class Wine
  attr_reader :type
  def initialize(type)
    set_type(type)
  end

  def set_type(type)
    case type.up_case
    when "R"
      @type = :red
    when "RED"
      @type = :red
    when "W"
      @type = :white
    when "WHITE"
      @type = :white
    else
      puts "Invalid Wine type! #{type}"
    end
  end
end