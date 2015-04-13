# encoding: utf-8
require 'sinatra'
require 'json'

dir = Dir[File.join(File.dirname(__FILE__),"lib","*.rb")]
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
    rescue BadArgError => e
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
    rescue BadArgError => e
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
    rescue BadArgError => e
      {errors: [
          {code: -1, message: e.message}
        ]
      }
    end
  end

  def delete_sub id
  end

end



##########################
######### Main ###########
##########################

vin = VinServer.new



##########################
###### Sinatra Part ######
##########################

set :port, 8080
set :environment, :production

get '/vin/sub/:uid' do
  vin.read_sub(params[:uid]).to_json
end

post '/vin/sub' do
  request.body.rewind
  data = JSON.parse request.body.read
  vin.create_sub(data).to_json
end

put '/vin/sub/:uid' do
  request.body.rewind
  data = JSON.parse request.body.read
  vin.update_sub(params[:uid], data).to_json
end

get '/vin/sub/:uid/search' do
  uid = params[:uid]
  q = params[:q]
end

get '/vin/sub/:uid/shipments' do
end

get '/vin/sub/:uid/shipments/:sid' do
end

put '/vin/sub/:uid/shipments/:sid' do
end

get '/vin/sub/:uid/shipments/:sid/notes' do
end

post '/vin/sub/:uid/shipments/:sid/notes' do
end

get '/vin/sub/:uid/shipments/:sid/notes/:nid' do
end

put '/vin/sub/:uid/shipments/:sid/notes/:nid' do
end

delete '/vin/sub/:uid/shipments/:sid/notes/:nid' do
end

get '/vin/sub/:uid/wines' do
end

get '/vin/sub/:uid/wines/:wid' do
end

get '/vin/sub/:uid/wines/:wid/notes' do
end

post '/vin/sub/:uid/wines/:wid/notes' do
end

get '/vin/sub/:uid/wines/:wid/notes/:nid' do
end

put '/vin/sub/:uid/wines/:wid/notes/:nid' do
end

delete '/vin/sub/:uid/wines/:wid/notes/:nid' do
end

get '/vin/sub/:uid/wines/:wid/rating' do
end

post '/vin/sub/:uid/wines/:wid/rating' do
end

get '/vin/sub/:uid/delivery' do
end

put '/vin/sub/:uid/delivery' do
end

