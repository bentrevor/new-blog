require 'sinatra'
require_relative 'lib/entry'

class SinatraApp < Sinatra::Base
  get '/' do
    erb :latest
  end

  get '/archives' do
    @entries = Entry.get_all
    erb :archives
  end
end
