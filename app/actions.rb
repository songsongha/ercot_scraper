#get '/' do
    # reads the index.html file in app/views
 # File.read(File.join('app/views', 'index.html'))
#end
helpers do
end

get '/' do
    
   
    # wtf_header = ["Be a fucking", "Why don't you be a god damn", "How about a fucking", "Lessen your family's shame by being a"]
    # @rand_header = wtf_header[rand(wtf_header.length)]
    # rand_page = rand(1..27310)

    # @website =  "https://www.jobbank.gc.ca/marketreport/summary-occupation/"
    # @website.concat("738", "/ca")
        
    # scraper = Scraper.new(@website)
    
    # @job_title =  scraper.search(".heading-info").strip
    
    # @wage_string = scraper.search("#j_id_3d_2_27 .section-value").strip
    # @wage = @wage_string.tr("$,/a-z ","").to_f
    # @wage_unit = @wage_string.tr("$.,/0-9 ","")
    
    # if @wage_unit == "hour"
    #     @wage_hour = @wage
    #     @wage_year = @wage * 2000
    # elsif @wage_unit == "year"
    #     @wage_year = @wage
    #     @wage_hour = @wage / 2000
    # else
    #     @wage_year = 5
    #     @wage_hour = 5
    # end

    # @education = scraper.search("#j_id_3d_2_20 .section-value").strip
       
    # postings = scraper.search("#j_id_3d_2_3z .section-value").strip
    # @num_posts = postings.tr("a-z ","").to_i


    # if @job_title.blank? 
    #     redirect to('/')
    # else
    #     erb(:index)
    # end

         
        (10000..27310).each do |n|
        url =  "https://www.jobbank.gc.ca/marketreport/summary-occupation/"
        url.concat("#{n}", "/ca")
      
        scraper = Scraper.new(url)
        job_title =  scraper.search(".heading-info").strip
    
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

            if job_title.present? 
                job.save
            end
         end
end

get '/search' do
  
    erb(:search)

end

post '/search' do
    wage = params[:wage]
    requirements = params[:requirements]
    num_posts = params[:num_posts]
params.to_s

    # plenty_jobs = Job.where("num_posts > ?", posts)
    # education2 = Job.where("requirements LIKE ?", "%" + requirements[1] + "%")
    # education3 = Job.where(requirements: requirements)
    # education4 = Job.where("num_posts > ? AND wage = ?", num_posts, "23.08/hour")
    # plenty_jobs.to_s
end

 
