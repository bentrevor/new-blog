require 'entry'

describe Entry do
  it "has a title" do
    entry = Entry.new "2013-01-01_Entry-Title.markdown"
    entry.title.should == "Entry Title"
  end

  it "has a date" do
    entry = Entry.new "2013-01-01_Entry-Title.markdown"
    entry.date.should == "Jan 1"

    entry = Entry.new "2013-11-11_Entry-Title.markdown"
    entry.date.should == "Nov 11"
  end

  it "looks in the /public/entries directory for entries" do
    Dir.should_receive(:foreach).with("public/entries").and_return []

    Entry.get_all
  end

  it "can return all entries in public/entries" do
    Dir.stub(:foreach)
       .and_return ["2013-01-01_First-Title.markdown", 
                    "2013-01-01_Second-Title.markdown",
                    "2013-01-01_Third-Title.markdown"]

    Entry.get_all.first.title.should == "First Title"
    Entry.get_all.last.title.should == "Third Title"
  end
end

