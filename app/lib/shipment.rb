# encoding: utf-8
require File.join(File.dirname(__FILE__), "./wine.rb")

class Shipment
  attr_reader :package
  def initialize(wines, type)
    @@red ||= -1
    @@white ||= -1
    choose_wine_ids(wines)
    @package = make_package(type)
  end

  def choose_wine_ids(wines)
    wines.each_with_index do |wine, i|
      if (wine.type == :red && i > @@red)
        @@red = i
      elsif (wine.type == :white && i > @@white)
        @@white = i
      end 
    end
  end

  def make_package(type)
    result = []
    case type.upcase
    when "AR"
      6.times { result << @@red }
    when "AW"
      6.times { result << @@white }
    when "RW"
      3.times { result << @@red }
      3.times { result << @@white }
    when "WR"
      3.times { result << @@red }
      3.times { result << @@white }
    else
      puts "Invalid shipment type #{type}"
    end

    return result
  end

end
