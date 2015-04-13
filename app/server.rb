# encoding: utf-8
require "socket"

class Request
  attr_reader :method, :path, :http, :request
  def initialize(req)
    @request = parse(req)
  end

  def parse(req)
    request_ary = req.split(" ")
    @method = request_ary[0]
    @path = request_ary[1].split("/").drop(1)
    @http = request_ary[2]  
    return req
  end
end

server = TCPServer.new('localhost', 8080)

loop do
  socket = server.accept

  puts socket.gets.to_s
  puts socket.gets.to_s

  # request = Request.new(socket.gets)

  # puts request.request.to_s

  # if (request.path[0] == "vin")
    socket.puts "Hello World !"
    socket.puts "Time is #{Time.now}"
  # else
  #   socket.puts "Invalid path request"
  # end
  socket.close
end