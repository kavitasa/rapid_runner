require 'mechanize'
require 'open-uri'

class Scraper

  def initialize
    ["CA", "CO"].each do |state_abbr|
      rivers = scrape_rivers(state_abbr)
      add_to_database(rivers)
    end
  end

  def scrape_rivers(state)
    scraper = WebBasedRiverScraper.new(state)
  end

  def scrape_rivers(state_abbr)
    # state_abbr = state_abbr.upcase[0..1]
    url = "http://www.americanwhitewater.org"
    state_url = "/content/River/state-summary/state/" + state_abbr
    washington_rivers = HTMLRiverParser.new(Nokogiri::HTML(open(url + state_url)))
    parse_river_section(section_details)
    washington_rivers.css("tr.low").each do |river_section|
      river = River.new(:name => river_section.river_name)
      river.sections << Section.new(:name => river.section.section_name)
      river_name = river_section.children[3].text.split("\n")[1].strip
      next unless river_name
      # puts ">>>#{river_name}<<<"
      section_url = river_section.children.children[2].attributes["href"].value
      aw_section_id = section_url.split("/").last
      directions_url = "/content/River/show-directions/reachid/#{aw_section_id}/revision/0/.rawhtml"
      begin
        section_name = /(\d+[ \.-]+)?(.+)/.match(river_section.children[3].text.split("\n")[4])[2]
        water_class = river_section.children[5].text
        section_directions = Nokogiri::HTML(open(url + directions_url))
        takeout = section_directions.css("table").children.children.children[4].attributes["fromzip"].value
        putin = section_directions.css("table").children.children.children[4].attributes["zipcenter"].value
        # guage
        # range
        # length
        # gradient
      rescue
      end
    end

  end

  def parse_river_section(section_details)

  end

  def add_to_database(rivers)
    rivers.map(&:name).save!
  end
end

class State
  def to_s
    abbr.upcase
  end
end

class HTMLRiverParser
  def initialize(data_source)
    @data_source = data_source
  end

  def method_missing(*args, &block)
    @data_source.send(*args, &block)
  end
end

#doc = Nokogiri::HTML(open("http://www.americanwhitewater.org/content/River/show-directions/reachid/3476/revision/0/.rawhtml")

# putin/takeout = table.children.children.children[4].attributes["fromzip"].value
# putin/takeout = table.children.children.children[4].attributes["zipcenter"].value


#doc2 = Nokogiri::HTML(open("http://www.americanwhitewater.org/content/River/detail/id/3476/#main"))

# river name & section = doc2.css("h1").first.children.text

#doc3 = Nokogiri::HTML(open("http://www.americanwhitewater.org/content/River/state-summary/state/WA/"))

# url = doc3.css("a.rivername").first["href"]
# river id = url.split("/")[-1]
# river name = doc3.css("a.rivername").first.children.text.strip
              #  oc3.css("tr.low").first.children.children[2].text
# river section: a = doc3.css("span.river_extra").first.children.text.split
                #  a..shift.join(",")
# river class: doc3.css("tr.low").first.children.children[8].text
