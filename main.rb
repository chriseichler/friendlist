require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

get '/' do
    erb :home
end

get '/new' do
    erb :new
end

get '/friends' do
    conn = PG.connect(dbname: 'friends', host: 'localhost')
    sql_command = ('SELECT * FROM friend')
    @rows = conn.exec(sql_command)
    @rows.each { |row| puts row }
    erb :friends
end

post '/create' do
    name = params[:name] || ''
    age = params[:age] || "0" 
    gender = params[:gender] || ''
    image = params[:gemder] || ''
    twitter = params[:twitter] || ''
    github = params[:github] || ''

    conn = PG.connect(dbname: 'friends', host: 'localhost')
    sql_command = "INSERT INTO friend(name, age, gender, image, twitter, github)
                    VALUES('#{name}', #{age}, '#{gender}', '#{image}', '#{twitter}', '#{github}')"
    conn.exec(sql_command)
    redirect '/'
end
