#encoding: utf-8

# A simple object to store arrays in memory, simulating a live DB
class VinDb
  attr_accessor :subscribers, :wines, :packages, :deliveries
  def initialize
    @subscribers = Array.new
    @wines = Array.new
    @packages = Array.new
    @deliveries = Array.new
  end
end
