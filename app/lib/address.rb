#encoding: utf-8
require File.join(File.dirname(__FILE__), "bad_arg_error.rb")

class Address
  attr_reader :street, :city, :state, :zip
  def initialize(street="", city="", state="", zip="")
    @street = street
    @city = city
    @state = state
    @zip = zip
    check_address
  end

  def check_address
    params = {street: @street, city: @city, state: @state, zip: @zip}
    params.each do |k, v|
      if v.length < 1
        raise BadArgError, "Bad address, #{k} not valid"
      end
    end
  end
end
