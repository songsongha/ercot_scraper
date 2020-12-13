#get '/' do
    # reads the index.html file in app/views
 # File.read(File.join('app/views', 'index.html'))
#end
helpers do
    #nothing here yet
end

get '/' do
    
    wtf_header = ["Be a fucking", "Why don't you be a god damn", "How about a fucking"]
    @rand_header = wtf_header[rand(wtf_header.length)]
    erb(:index)
end

 
