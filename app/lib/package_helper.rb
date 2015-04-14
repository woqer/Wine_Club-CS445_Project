#encoding: utf-8

###########################################################
### PackageHelper
### => simulates a DB with a shipment (packages) class
### => columns defined in hash template (future schema)
### => also provides the methods for the model
###########################################################


require 'nokogiri'
require File.join(File.dirname(__FILE__), "wine.rb")
require File.join(File.dirname(__FILE__), "bad_arg_error.rb")

class PackageHelper
  attr_reader :wines
  def initialize
    @table = template
    @id = 0
    @wines = wines_init
    @deleted = []
  end

  ### initializers ###

  def template
    {
      id: [],
      wines: [], # each entry has an array of 6 wid (wine id)
      note: [],
      price: [],
      sub: [],
      year: [],
      month: [],
      dow: [],
      tod: []
    }
  end

  def wines_init
    f = File.open(File.join(File.dirname(__FILE__), "..", "..", "data", "wines.xml"))
    doc = Nokogiri::XML(f)
    f.close
    names = []
    types = []
    result = []

    doc.xpath("//root/wine/name").each do |name|
      names.push(name.text)
    end
    
    doc.xpath("//root/wine/type").each do |type|
      types.push(type.text)
    end

    names.each_with_index do |name, i|
      result.push(Wine.new(name, types[i]))
    end

    return result
  end
  
  ### validators ###

  def validate?
    size = @id

    puts size
    puts @table.to_s
    puts @table[:wines].length

    @table.each do |k, v|
      return false if (v.length != size)
    end

    return true
  end

  def validate_hash?(hash)
    return false if (hash.length != 8)
    return false if (hash[:wine].length != 6)

    args = []

    (template).each do |k, v|
      if (k != :id)
        return false if hash[k].nil?
        args.push(v)
      end
    end

    ensure_args(args)
  end

  def ensure_args(wines, note, price, sub, year, month, dow, tod)
    wines.each do |i|
      if (@wines[i].class.name != "Wine")
        raise BadArgError, "Win class"
      end
    end
    
    if (wines.length != 6)
      raise BadArgError, "wine length (should be 6)"
    end

    if (sub.class.name != "Subscriber")
      raise BadArgError, "subscriber class"
    end

    if ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].index(dow.capitalize).nil?
      raise BadArgError, "Bad day of week"
    end

    if ["AM", "PM"].index(tod.upcase).nil?
      raise BadArgError, "Bad time of day #{tod}, should be (AM/PM)"
    end

    return true
  end

  ##########################################
  ### Basic operations                   ###
  ###   - add, get, update, delete, find ###
  ##########################################


  def add(wines, note="", price=100, sub, year, month, dow, tod)
    raise BadArgError, "Broken Package table" unless validate?
    
    begin
      ensure_args(wines, note, price, sub, year, month, dow, tod)
    rescue => e
      raise BadArgError, "Malformed package arguments: #{e.message}"
    end

    @table[:id].push(@id)
    @id += 1
    @table[:wines].push(wines)
    @table[:note].push(note)
    @table[:price].push(price)
    @table[:sub].push(sub)
    @table[:year].push(year)
    @table[:month].push(month)
    @table[:dow].push(dow)
    @table[:tod].push(tod)
    @deleted.push(false)
  end

  def get index
    result = {}
    (template).each do |k, v|
      result[k] = @table[k][index]
    end
    return result
  end

  def update(index, hash)
    return false unless validate_hash?(hash)
    hash.each do |k, v|
      @table[k] = v
    end
    return true
  end

  def delete index
    @deleted[index] = true
  end

  # returns an array of ids
  def find(key, value)
    @table[key].each_index.select { |i| @table[key][i].eql?(value) }
  end

  def find_package_index_with_wines(wids)
    result = []
    wids.each do |wid|
      indexes = @table[:wines].each_index.select do |i|
        @table[:wines][i].index(wid)
      end
      result.concat(indexes)
    end
    return result
  end

  ### App model logic methods ###

  def wines_make_ary(indexes, q)
    result = []
    wines_uniq = []
    type = Wine.get_type(q)
    indexes.each do |id|
      @table[:wines][id].uniq.each { |wid| wines_uniq.push(wid) }
      wines_uniq.uniq!
    end

    wines_uniq.each do |wid|
      if type.empty?
        result.push({ id: wid, label_name: @wines[wid].name })
      elsif @wines[wid].type == type
        result.push({ id: wid, label_name: @wines[wid].name })
      end
    end

    return result
  end

  def notes_make_ary(indexes)
    result = []
    indexes.each do |id|
      result.push( @table[:note][id] )
    end
    return result
  end

  def shipments_make_ary(indexes)
    result = []
    indexes.each do |id|
      selection_month = @table[:month][id]
      selection_month << "/"
      selection_month << @table[:year][id].to_s
      result.push({ id: id, selection_month: "#{selection_month}" })
    end
    return result
  end

end

# ph = PackageHelper.new
# ph.wines.each do |wine|
#   puts "#{wine.type} => #{wine.name}"
# end
