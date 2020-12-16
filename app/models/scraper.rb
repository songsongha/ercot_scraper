require 'wombat'

class Scraper 
    include Wombat::Crawler
    base_url "https://www.jobbank.gc.ca"
    path "/marketreport/summary-occupation/15/ca"
  
    job_title "css=.heading-info"
   # stats do |title|
       # title.dev_number "css=.home-hero .col-sm-4.col-md-3 h2"
  #  end
end
