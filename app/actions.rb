#get '/' do
    # reads the index.html file in app/views
 # File.read(File.join('app/views', 'index.html'))
#end

require 'thread/pool'

helpers do
end


get '/' do
   
    wtf_header = ["Be a fucking", "Why don't you be a god damn", "How about a fucking", "Lessen your family's shame by being a"]
    @rand_header = wtf_header[rand(wtf_header.length)]
    rand_page = rand(1..27310)

    @website =  "https://www.jobbank.gc.ca/marketreport/summary-occupation/"
    @website.concat("#{rand_page}", "/ca")
        
    scraper = Scraper.new(@website)
    
    @job_title =  scraper.search(".heading-info").strip
    
    @wage_string = scraper.search("#j_id_3d_2_27 .section-value").strip
    @wage = @wage_string.tr("$,/a-z ","").to_f
    @wage_unit = @wage_string.tr("$.,/0-9 ","")
    
    if @wage_unit == "hour"
        @wage_hour = @wage
        @wage_year = @wage * 2000
    elsif @wage_unit == "year"
        @wage_year = @wage
        @wage_hour = @wage / 2000
    else
        @wage_year = 5
        @wage_hour = 5
    end

    @education = scraper.search("#j_id_3d_2_20 .section-value").strip
       
    postings = scraper.search("#j_id_3d_2_3z .section-value").strip
    @num_posts = postings.tr("a-z ","").to_i


    if @job_title.blank? 
        redirect to('/')
    else
        erb(:index)
    end
#  pool = Thread.pool(15)

#     database = []
#     (15001..27310).each do |n|
#         url =  "https://www.jobbank.gc.ca/marketreport/summary-occupation/"
#         url.concat("#{n}", "/ca")
        
#         pool.process do

#             scraper = Scraper.new(url)
#             job_title =  scraper.search(".heading-info").strip

#             if job_title.present? 
#                 wage_string = scraper.search("#j_id_3d_2_27 .section-value").strip
#                 wage = wage_string.tr("$,/a-z ","").to_f
#                 wage_unit = wage_string.tr("$.,/0-9 ","")

#                 if wage_unit == "hour"
#                     wage_hour = wage
#                     wage_year = wage * 2000
#                 elsif wage_unit == "year"
#                     wage_year = wage
#                     wage_hour = wage / 2000
#                 else
#                     wage_year = 0
#                     wage_hour = 0
#                 end

#                 education = scraper.search("#j_id_3d_2_20 .section-value").strip

#                 postings = scraper.search("#j_id_3d_2_3z .section-value").strip
#                 num_posts = postings.tr("a-z ","").to_i

#                 job = Job.new({ 
#                 job_title: job_title,
#                 url: url,
#                 wage_hour: wage_hour,
#                 wage_year: wage_year,
#                 education: education,
#                 num_posts: num_posts })

#                 database << job
#             end
#         end
#     end 
    
#     pool.shutdown 
    
#     Job.import database
end

get '/search' do
    @search_header = "What the fuck do you want then?"
    erb(:search)
end

post '/search' do
    wage = params[:wage]
    wage_unit = params[:wage_unit]
    education = params[:education] #need to check for errors, user must check at least 1
    num_posts = params[:num_posts]
    @num_options = params[:num_options]
    
    if wage_unit == "hour"
        @query = Job.where("num_posts >= ? AND wage_hour > ? AND education IN (?)", num_posts, wage, education)
    else 
        @query = Job.where("num_posts >= ? AND wage_year > ? AND education IN (?)", num_posts, wage, education)
    end

    if @query.present?
        erb(:displaytest)
    else
        @error_message = "No job in Canada fucking meets those standards"
        erb(:search)
    end

    

    # @rand_query = rand(@query.length)
    # if @query.present? && num_options == "1"
    #     erb(:display1)
    # elsif @query.present? && num_options == "10"
    #     @query_10 = @query.limit(10).order("RANDOM()")
    #     erb(:display10)
    # else
    #     @error_message = "No job in Canada fucking meets those standards"
    #     erb(:search)

    # end
    
end




 
