require 'sinatra'

class SinatraApp < Sinatra::Base
  get '/' do
    @latest = File.read(File.open("public/entries/test.html"))
    erb :latest
  end

  get '/archives' do
    @entries = all_entries
    erb :archives
  end

  def all_entries
    entries = []

    Dir.foreach("public/entries") do |entry|
      next if entry == '.' or entry == '..'
      entries << entry
    end

    entries
  end
end
