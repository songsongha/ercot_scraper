
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
     
    @pathname = "/marketreport/summary-occupation/"
    @pathname.concat("#{@rand_job}", "/ca")

    scraper = Scraper.new()
    scraper.crawl.to_json
    
    #erb(:index)


end

 
