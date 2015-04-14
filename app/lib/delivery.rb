# encoding: utf-8
require 'nokogiri'

class Delivery
  attr_reader :check_adult, :day_of_week, :time, :package

  def initialize(package, day_of_week, time)
    @package = package
    @day_of_week = day_of_week
    @time = time
  end

  def check_illegal_state(name)
    f = File.open(File.join(File.dirname(__FILE__), "..", "..", "data", "illegal_states.xml"))
    doc = Nokogiri::XML(f)
    f.close

    states = doc.xpath("//root/illegal/state")

    match = states.select { |s| s.text==name }

    return match.length > 0
  end

end
