require 'sinatra'

class SinatraApp < Sinatra::Base
  get '/' do
    erb :home
  end
end
