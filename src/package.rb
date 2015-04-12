# encoding: utf-8

class Package
  def initialize(red, white)
    @red = red
    @white = white
  end

  def n_red
    @red
  end

  def n_white
    @white
  end

  def illegal_note
  end

  def note(text="")
    if (text.length == 0)
      return @note
    elsif (text.length < 128 || text.length > 1024)
      illegal_note
    else
      @note = text
    end
    return @note
  end
  
  def price
    @price
  end
end