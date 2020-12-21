
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
    rand_page = rand(1..27310)
    
    base_url =  "https://www.jobbank.gc.ca"
    pathname = "/marketreport/summary-occupation/"
    pathname.concat("#{rand_page}", "/ca")
    @website = base_url + pathname
    
    scraper = Scraper.new(base_url, pathname)
    @job_title =  [
        scraper.search(".heading-info").strip
    ]
    if @job_title[0].blank? 
        redirect to('/')
    else
        erb(:index)
    end

end

 
