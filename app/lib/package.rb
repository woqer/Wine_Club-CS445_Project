# encoding: utf-8

class Package
  attr_reader :n_red, :n_white, :note, :price
  def initialize(red, white, price, note)
    @red = red
    @white = white
    @price = price
    @note = set_note(note)
  end

  def illegal_note
    puts "Package: illegal note"
    @note = ""
  end

  def set_note(text="")
    if (text.length == 0)
      return @note
    elsif (text.length < 128 || text.length > 1024)
      illegal_note
    else
      @note = text
    end
    return @note
  end
end
