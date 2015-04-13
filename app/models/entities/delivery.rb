# encoding: utf-8
require 'nokogiri'

class Delivery

  def match_in_array(array, name)

  end

  def check_illegal_state(name)
    f = File.open('../data/illegal_states.xml')
    doc = Nokogiri::XML(f)
    f.close

    states = doc.xpath("//root/illegal/state")

    match = states.select { |s| s.text==name }

    return match.length > 0
  end

  def check_adult
  end

  def day_of_week
  end

  def time
  end

end

delivery = Delivery.new

puts delivery.check_illegal_state("Alabama")
puts delivery.check_illegal_state("Illinois")
