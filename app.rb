require 'sinatra'
require 'tilt/erb'

get '/' do
  erb :index
end

not_found do
  erb :error
end

error do
  erb :error
end
