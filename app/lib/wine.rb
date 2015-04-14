# encoding: utf-8

class Wine
  attr_reader :type, :name
  def initialize(name, type)
    @name = name
    set_type(type)
  end

  def set_type(type)
    case type.upcase
    when "R"
      @type = :red
    when "RED"
      @type = :red
    when "W"
      @type = :white
    when "WHITE"
      @type = :white
    else
      raise BadArgError, "Invalid Wine type! #{type}"
    end
  end

  def self.get_type(type)
    case type.upcase
    when "R"
      :red
    when "RED"
      :red
    when "W"
      :white
    when "WHITE"
      :white
    else
      :""
    end
  end

end
