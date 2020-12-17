require 'wombat'

#get '/' do
    # reads the index.html file in app/views
 # File.read(File.join('app/views', 'index.html'))
#end
helpers do
    #nothing here yet
end

get '/' do
    
    wtf_header = ["Be a fucking", "Why don't you be a god damn", "How about a fucking", "Lessen your family's shame by being a"]
    @rand_header = wtf_header[rand(wtf_header.length)]
    @rand_job = rand(1..27310)
     
    @path = "/marketreport/summary-occupation/"
    @path.concat("16", "/ca")

    @job = Wombat.crawl do
   base_url "https://www.jobbank.gc.ca"
    path "#{@path}"
  
    job_title "css=.heading-info"
end

   # scraper = Scraper.new(path)
    #@job = scraper.crawl
    @job.to_json
  # erb(:index)
end

 
