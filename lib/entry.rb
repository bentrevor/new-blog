class Entry
  attr_accessor :title, :date

  def initialize(filename)
    extract_date_from filename
    extract_title_from filename
  end

  def self.get_all
    entries = []

    filenames = Dir.foreach("public/entries") 

    filenames.each do |filename|
      next if filename == '.' or filename == '..'
      entries << Entry.new(filename)
    end

    entries
  end

  private

  def extract_title_from(filename)
    self.title = filename.split('_')[1].split('.')[0].gsub('-', ' ')
  end

  def extract_date_from(filename)
    date = filename.split('_')[0]
    parsed_date = Date.parse date
    month = parsed_date.strftime "%b"
    day = parsed_date.strftime("%e").lstrip

    self.date = month + " " + day
  end
end
