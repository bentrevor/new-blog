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

    filenames = Dir.foreach("public/entries") 

    filenames.each do |filename|
      next if filename == '.' or filename == '..'
      entries << to_title(filename)
    end

    entries
  end

  def to_title(filename)
    title = ""

    title << filename.split('_')[1].split('.')[0].gsub('-', ' ')

    title
  end
end
