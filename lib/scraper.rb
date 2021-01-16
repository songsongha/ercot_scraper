require 'mechanize'

class Scraper 
    def initialize(url)
        @url = url
        @agent = self.get
    end

    def get
    Mechanize.new.get("#{@url}")
    end

    def search(selector)
        @agent.search(selector).text
    end

end
