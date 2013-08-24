require_relative '../sinatra_app'
require 'capybara/rspec'

Capybara.app = SinatraApp

describe SinatraApp, :type => :feature do
  describe "/archives" do
    it "looks in the /public/entries directory for entries" do
      Dir.should_receive(:foreach).with("public/entries")

      visit '/archives'
    end

    it "links to all entries in public/entries" do
      add_three_dummy_entries

      visit '/archives'

      page.should have_link("First Title", :href => "1")
      page.should have_link("Second Title", :href => "2")
      page.should have_link("Third Title", :href => "3")
    end

    it "puts the date after entry titles" do
      add_three_dummy_entries

      visit '/archives'

      page.should have_content("First Title - Jan 1")
      page.should have_content("Second Title - Feb 2")
      page.should have_content("Third Title - Mar 3")
    end
  end

  private

  def add_three_dummy_entries
    Dir.stub(:foreach)
       .and_return ["2013-01-01_First-Title.markdown", 
                    "2013-02-02_Second-Title.markdown",
                    "2013-03-03_Third-Title.markdown"]
  end
end
