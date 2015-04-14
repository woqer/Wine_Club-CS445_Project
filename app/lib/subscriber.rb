# encoding: utf-8
require 'json'
require File.join(File.dirname(__FILE__), "person.rb")
require File.join(File.dirname(__FILE__), "address.rb")
require File.join(File.dirname(__FILE__), "bad_arg_error.rb")

class Subscriber < Person
  attr_reader :email, :phone, :address, :fb, :tw
  def initialize(name="", email="",
      phone="", address=Address.new, fb="", tw="")
      super(name)
      @email = email
      @phone = phone
      @address = address
      @fb = fb
      @tw = tw
      check_contact
  end

  def to_h
    {
      name: @name,
      email: @email,
      phone: @phone,
      address: {
        street: @address.street,
        city: @address.city,
        state: @address.state,
        zip: @address.zip
      },
      fb: @fb,
      tw: @tw,
    }
  end

  def check_contact
    if @phone.length < 1
      raise BadArgError, "Bad Subscriber phone"
    end
    check_email_format
  end

  def check_email_format
    begin
      server = @email.split("@")[1].split(".")
      if server.length < 2
        raise BadArgError, "Bad user email format !"
      end
    rescue
      raise BadArgError, "Bad user email format !"
    end
  end

  def compare_email_formater(email)
    email_ary = email.split("@")
    email_ary[1].delete!(".+")
    email_ary.join("@")
  end

  def eql?(obj)
    me = compare_email_formater(@email)
    other = compare_email_formater(obj.email)
    me.eql?(other)
  end
end
