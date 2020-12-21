require 'mechanize'

class Scraper 
    def initialize(base_url, path)
        @base_url = base_url
        @path = path
        @agent = Mechanize.new
    end

    def search(selector)
        @agent.get("#{@base_url}#{@path}").search(selector).text
    end

end
