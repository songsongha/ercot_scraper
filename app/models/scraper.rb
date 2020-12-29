require 'mechanize'

class Scraper 
    def initialize(url)
        @url = url
        @agent = Mechanize.new
    end

    def search(selector)
        @agent.get("#{@url}").search(selector).text
    end

end
