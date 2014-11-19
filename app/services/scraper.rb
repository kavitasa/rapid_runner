require 'mechanize'
require 'open-uri'

class Scraper

    url1 = "/content/River/show-directions/reachid/3476/revision/0/.rawhtml"
    # url2 = "/content/River/detail/id/3476"
    url3 = "/content/River/state-summary/state/WA"]


  def scrape_rivers(urls)

      washington_rivers = Nokogiri::HTML(open("http://www.americanwhitewater.org" + url3))
      # slug =
      #doc3.css("tr.low").first.children.children[8].text
      washington_rivers.css("tr.low").each do |river|
        name = #river.children.text.strip
        section =
        aw_id =
        stlate =
        water_class =
        river_url = "/content/River/show-directions/reachid/#{aw_id}/revision/0/.rawhtml"


        # go the specific river's page
        #  takeout =
        #  putin =

        # do something with this data :)
      end



      # guage
      # range
      # length
      # gradient
    end

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

# Feature: Finding rivers by state
#
# Given I am a user
#   And I am logged in
# When I do that something
# Then I check that the things that were supposed to happen happend
