require 'mechanize'
require 'open-uri'

class Scraper

  def initialize
    ["CA", "CO"].each do |state_abbr|
      rivers = scrape_rivers(state_abbr)
      # add_to_database(rivers)
    end
  end
  # run Scraper.new in rails c

  # def scrape_rivers(state)
  #   scraper = WebBasedRiverScraper.new(state)
  # end

  def scrape_rivers(state_abbr)
    @url = "http://www.americanwhitewater.org"
    state_url = "/content/River/state-summary/state/" + state_abbr
    washington_rivers = HTMLRiverParser.new(Nokogiri::HTML(open(@url + state_url)))
    # washington_rivers = Nokogiri::HTML(open(url + state_url))
    section_details = washington_rivers.css("tr.low")
    parse_river_section(section_details)
    end

  end

  def parse_river_section(section_details)
    results = {:section => []}

    section_details.each_with_index do |river_section, i|
      # river = River.new(:name => river_section.river_name)
      # river.sections << Section.new(:name => river.section.section_name)
      # puts ">>>#{river_name}<<<"
      section_url = river_section.children.children[2].attributes["href"].value
      aw_section_id = section_url.split("/").last
      directions_url = "/content/River/show-directions/reachid/#{aw_section_id}/revision/0/.rawhtml"
      section_directions = HTMLRiverParser.new(Nokogiri::HTML(open(@url + directions_url)))
      parse_river_name(river_section)
      next unless @river_name
      begin
        parse_section_name(river_section)
        # puts ">>>#{@section_name}<<<"
        parse_water_class(river_section)
        # puts ">>>#{@water_class}<<<"
        # section_directions = Nokogiri::HTML(open(@url + directions_url))
        parse_takeout(section_directions)
        # puts ">>>#{@takeout}<<<"
        parse_putin(section_directions)
        # puts ">>>#{@putin}<<<"

        # guage
        # range
        # length
        # gradient
      rescue
    end

    results[:section] << {
      river_name: river_name,
      section_name: section_name,
      water_class: water_class,
      takeout_long: takeout_long,
      takeout_lat: takeout_lat,
      putin_long: putin_long,
      putin_lat: putin_lat
    }

    rescue
      puts "Failed to fully load #{i} river #{river_name}, section #{section_name}"
    end

    results

  end

  def parse_river_name(river_section)
    @river_name = river_section.children[3].text.split("\n")[1].strip
  end

  def parse_section_name(river_section)
    @section_name = /(\d+[ \.-]+)?(.+)/.match(river_section.children[3].text.split("\n")[4])[2]
  end


  def parse_water_class
    @water_class = river_section.children[5].text
  end

  def parse_takeout(section_directions)
    takeout = section_directions.css("table").children.children.children[4].attributes["fromzip"].value
    takeout_long = takeout.split(",")[0].to_f
    takeout_lat = takeout.split(",")[1].to_f
  end

  def parse_putin(section_directions)
    putin = section_directions.css("table").children.children.children[4].attributes["zipcenter"].value
    putin_long = putin.split(",")[0].to_f
    putin_lat = putin.split(",")[1].to_f
  end

  def add_to_database(rivers)
    rivers.map(&:save!)
  end
end

#doc = Nokogiri::HTML(open("http://www.americanwhitewater.org/content/River/show-directions/reachid/3476/revision/0/.rawhtml"))

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
