# encoding: utf-8
require 'sinatra'
require 'json'

dir = Dir[File.join(File.dirname(__FILE__),"models", "entities","*.rb")]
dir.each do |file|
  require file
end

class VinServer
  attr_reader :subscribers
  def initialize
    @subscribers = Array.new
  end

  def parse_sub data
    address = Address.new(data['address']['street'],
        data['address']['city'], data['address']['state'],
        data['address']['zip'])
    Subscriber.new(data['name'], data['email'],
        data['phone'], address, data['facebook'], data['twitter'])
  end

  # adds new subscriber, returns id
  def create_sub data
    begin
      id = @subscribers.push(parse_sub(data)).length - 1
      {
        id: id,
        errors: []
      }
    rescue => e
      {
        id: nil,
        errors: [
          {code: -1, message: e.message}
        ]
      }
    end
  end

  def read_sub id
    begin
      @subscribers[id.to_i].to_h
    rescue => e
      {errors: [
          {code: -1, message: "Unexistent user"}
        ]
      }
    end
  end

  def update_sub id, data
    begin
      @subscribers[id.to_i] = parse_sub(data)
      {errors: []}
    rescue => e
      {errors: [
          {code: -1, message: e.message}
        ]
      }
    end
  end

  def delete_sub id
  end

end

vin = VinServer.new

###### Sinatra Part ######

set :port, 8080
set :environment, :production

get '/vin/sub/:id' do
  vin.read_sub(params[:id]).to_json
end

post '/vin/sub' do
  request.body.rewind
  data = JSON.parse request.body.read
  vin.create_sub(data).to_json
end

put '/vin/sub/:id' do
  request.body.rewind
  data = JSON.parse request.body.read
  vin.update_sub(params[:id], data).to_json
end
