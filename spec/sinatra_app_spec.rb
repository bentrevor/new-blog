require_relative '../sinatra_app'
require 'capybara/rspec'

Capybara.app = SinatraApp

describe SinatraApp, :type => :feature do
  describe "/archives" do
    it "links to all entries in public/entries" do
      Dir.should_receive(:foreach).with("public/entries").and_return ["2013-01-01_First-Title.markdown", "2013-01-01_Second-Title.markdown", "2013-01-01_Third-Title.markdown"]
      visit '/archives'
      puts page.body
      page.should have_link("First Title", :href => "1")
      page.should have_link("Second Title", :href => "2")
      page.should have_link("Third Title", :href => "3")
    end
  end

  describe "file_to_title" do
    it "converts a filename to a title" do
      Dir.stub(:foreach).and_return ["2013-01-01_First-Title.markdown"]
      visit '/archives'
      page.should have_link("First Title", :href => "1")
    end

    it "puts the date after the title" do
      Dir.stub(:foreach).and_return ["2013-01-01_First-Title.markdown", "2013-01-02_Second-Title.markdown", "2013-01-03_Third-Title.markdown"]
      visit '/archives'
      page.should have_content "01-01-2013"
      page.should have_content "01-02-2013"
      page.should have_content "01-03-2013"
    end
  end
end
