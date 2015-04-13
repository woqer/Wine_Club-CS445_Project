#encoding: utf-8

class DbHelper
  def initialize
    @table = Array.new
    @id = 0
  end

  def add element
    @table.push(element)
    @id += 1
  end

  def get index
  end

  def update index
  end

  def delete index
  end

  def search element
  end

end
