# encoding: utf-8

class Package
  attr_reader :wines, :note, :price
  def initialize(wines, price, note)
    @wines = wines
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
