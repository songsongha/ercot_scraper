
helpers do
end


get '/' do
    
    wtf_header = ["Be a fucking", "Why don't you be a god damn", "How about a fucking", "Lessen your family's shame by being a"]
    @rand_header = wtf_header[rand(wtf_header.length)]
    
    rand_job = Job.order('RANDOM()').first
    @job_title = rand_job.job_title
    @url = rand_job.url
    erb(:index)
    
end

get '/search' do
    @search_header = "What the fuck do you want then?"
    erb(:search)
end

get '/search_results' do
    wage = params[:wage]
    wage_unit = params[:wage_unit]
    education = params[:education] 
    num_posts = params[:num_posts]
        
    if wage_unit == "hour"
        @query = Job.where("num_posts >= ? AND wage_hour > ? AND education IN (?)", num_posts, wage, education)
    else 
        @query = Job.where("num_posts >= ? AND wage_year > ? AND education IN (?)", num_posts, wage, education)
    end
        
    if @query.present?
        erb(:search_results)
    else
        @error_message = "No job in Canada fucking meets those requirements"
        erb(:search)
    end
    
end

get '/scrape' do
    erb(:scrape)
end


post '/scrape' do
    password = params[:password]
    admin = Admin.find_by_id(1)

if admin.authenticate(password)
    require 'thread/pool'
    pool = Thread.pool(15)

    database = []
    (1..27350).each do |n|
        url =  "https://www.jobbank.gc.ca/marketreport/summary-occupation/"
        url.concat("#{n}", "/ca")
        
        pool.process do
            scraper = Scraper.new(url)
            job_title =  scraper.search(".heading-info").strip

            if job_title.present? 
                wage_string = scraper.search("#j_id_3d_2_27 .section-value").strip
                wage = wage_string.tr("$,/a-z ","").to_f
                wage_unit = wage_string.tr("$.,/0-9 ","")

                if wage_unit == "hour"
                    wage_hour = wage
                    wage_year = wage * 2000
                elsif wage_unit == "year"
                    wage_year = wage
                    wage_hour = wage / 2000
                else
                    wage_year = 0
                    wage_hour = 0
                end

                education = scraper.search("#j_id_3d_2_20 .section-value").strip

                postings = scraper.search("#j_id_3d_2_3z .section-value").strip
                num_posts = postings.tr("a-z ","").to_i

                job = Job.new({ 
                job_title: job_title,
                url: url,
                wage_hour: wage_hour,
                wage_year: wage_year,
                education: education,
                num_posts: num_posts })

                database << job
            end
        end
    end 
    pool.shutdown 
    Job.import database
    @message = "Scraping complete"
else
    @message = "Incorrect Password"
end
erb(:scrape)    

end





 
