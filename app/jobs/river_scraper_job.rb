 class RiverScraperJob
  @queue = :scraper

  def self.perform #pass in state as argument when multiples
    Scraper.new
  end
end

# run job in cmdln: rake environment resque:work QUEUE=scraper
