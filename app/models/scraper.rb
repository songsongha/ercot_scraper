require 'wombat'

class Scraper 
    def initialize(path)
        @path = path
    end

    def get
    include Wombat::Crawler
    base_url "https://www.jobbank.gc.ca"
    path "#{@path}"
  
    job_title "css=.heading-info"
   # stats do |title|
       # title.dev_number "css=.home-hero .col-sm-4.col-md-3 h2"
  #  end
    end
end

