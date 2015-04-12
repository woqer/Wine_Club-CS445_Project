# encoding: utf-8

class Subscribtion
  def initialize(type)
    case type
    when "AR"
      @package = Package.new(6,0)
    when "AW"
      @package = Package.new(0,6)
    when "RW"
      @package = Package.new(3,3)
    else
      @package = Package.new(3,3)
    end
  end
end
