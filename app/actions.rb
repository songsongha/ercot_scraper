
helpers do
    # def get_job(query)
    #     if query.present?
    #     @job_title = query.job_title
    #     @url = query.url
    #     else
    #         @job_title = "Radio Time Buyer in Canada"
    #         @url = "https://www.jobbank.gc.ca/marketreport/summary-occupation/555/ca"
    #     end
    # end
end


get '/' do    
    #  erb(:index)
    # require './lib/scraper'
    require 'mechanize'
    require 'csv'
    # set headers for CSV files
     CSV.open("max_million.csv", "w") do |max_csv|
        max_csv << ["date", "pos1", "pos2", "pos3", "pos4","pos5", "pos6", "pos7"]
     end
     CSV.open("main_draw.csv", "w") do |main_csv|
        main_csv << ["date", "pos1", "pos2", "pos3", "pos4","pos5", "pos6", "pos7", "bonus"]
     end

    url = "https://www.lottomaxnumbers.com/past-numbers"
    mechanize = Mechanize.new
    page = mechanize.get(url)
    draw_dates = page.search('.archive-date-link')
    #for each draw date scrape and store the date then click the linked get the data from each
    draw_dates.each do |draw_date|
        date = draw_date.text.strip
        link = page.link_with(text: date)
        detail_page_url = link.click.uri
        mechanize = Mechanize.new
        #scrape details for a specific draw date
        detail_page = mechanize.get(detail_page_url)
        result_array = []
        result_array << date
        #extract and store draw result in an array with each index referring to a draw position
        draw_results = detail_page.search('.topBox .balls li')
        draw_results.each do |draw_result|
            result_array << draw_result.text.strip
        end
        
        CSV.open("main_draw.csv", "a") do |main_csv|
            main_csv << result_array
        end  
        #extract and store max million results if they exist
        max_millions = detail_page.search('.max-millions-result')
        if max_millions.present?
            max_million_array = [] #an array of arrays each index is a group of max million results
            max_millions.each do |result| # for each result on the page get the individual result
                max_million = result.search('.balls li')
                result_array = [] #each index refers to a draw position
                result_array << date
                max_million.each do |result|
                    result_array << result.text.strip
                end
                CSV.open("max_million.csv", "a") do |max_csv|
                    max_csv << result_array
                end
            end
        end
  
    end  

end   
 
      #     link = page.link_with(text: 'Prev')
    #     page = link.click
    #     create_words(page.uri)
    
    # def create_words(url)
    
    #     mechanize = Mechanize.new
    #     page = mechanize.get(url)


    #     date = page.at('article div span').text.strip
    #     word_descriptions = page.search('div.wod-definition-container p')[0..-4]
    #     word_of_the_day = page.search('div.word-and-pronounciation h1').text.strip

    #     puts page.title[0..-18]
    #     puts "on #{date[18..date.length]} the word of the day is #{word_of_the_day}"
    #     puts ""
    #     puts "#{word_of_the_day} means:"

    #     word_descriptions.each do |description|
    #         if description == word_descriptions[-1]
    #             puts ""
    #             puts "Etiology: #{description.text}."
    #             puts "==============================="
    #         else
    #             puts description.text
    #         end
    #     end
    #     link = page.link_with(text: 'Prev')
    #     page = link.click
    #     create_words(page.uri)
    # end


    # start_url = "https://www.merriam-webster.com/word-of-the-day"
    # create_words(start_url)
                
    # .each do |x|
    #     puts x.text.strip
    #     num_extra << x.text.strip
    #     p num_extra
    # end


# post '/scrape' do
#     password = params[:password]
#     admin = Admin.find_by_id(1)

#     if admin.authenticate(password)
#         lower_range = params[:lower_range]
#         upper_range = params[:upper_range]
    
#         require 'thread/pool'
#         require './lib/scraper'
#         pool = Thread.pool(15)    
#         database = []
#         (lower_range..upper_range).each do |n|
#             url =  "https://www.jobbank.gc.ca/marketreport/summary-occupation/"
#             url.concat("#{n}", "/ca")
#             entry = Job.find_by(url: url)
#             if entry.present?
#                 entry.destroy
#             end

#             pool.process do
#                 scraper = Scraper.new(url)
#                 job_title =  scraper.search(".heading-info").strip
#                 if job_title.present? 
#                     wage_string = scraper.search("#j_id_3d_2_27 .section-value").strip
#                     wage = wage_string.tr("$,/a-z ","").to_f
#                     wage_unit = wage_string.tr("$.,/0-9 ","")

#                     if wage_unit == "hour"
#                         wage_hour = wage
#                         wage_year = wage * 2000
#                     elsif wage_unit == "year"
#                         wage_year = wage
#                         wage_hour = wage / 2000
#                     else
#                         wage_year = 0
#                         wage_hour = 0
#                     end

#                     education = scraper.search("#j_id_3d_2_20 .section-value").strip

#                     postings = scraper.search("#j_id_3d_2_3z .section-value").strip
#                     num_posts = postings.tr("a-z ","").to_i

#                     job = Job.new({ 
#                     job_title: job_title,
#                     url: url,
#                     wage_hour: wage_hour,
#                     wage_year: wage_year,
#                     education: education,
#                     num_posts: num_posts })

#                     database << job
#                 end
#             end
#         end 
#         pool.shutdown 
#         Job.import database
#         @message = "Scraping complete"
#     else
#         @message = "Incorrect Password"
#     end
#     erb(:scrape)    

# end





 
