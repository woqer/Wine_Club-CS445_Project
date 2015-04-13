# encoding: utf-8
require 'json'
require 'rest-client'

class VinClient
  attr_accessor :data
  def initialize
    @data = read_example
    @url = URI::encode("http://localhost:8080/vin/")
  end

  def read_example example="sub_example.json"
    file = File.read(File.join(File.dirname(__FILE__), "data", example))
    JSON.parse(file)
  end

  def create_sub
    url = URI::join(@url, "sub")
    response = RestClient.post url.to_s, @data.to_json
    JSON.parse(response)
  end

  def update_sub id
    url = URI::join(@url, "sub/", "#{id}")
    response = RestClient.put url.to_s, @data.to_json
    JSON.parse(response)
  end

  def get_sub id
    url = URI::join(@url, "sub/", "#{id}")
    response = RestClient.get url.to_s
    JSON.parse(response)
  end

  def print_json
    @data.to_json
  end
end