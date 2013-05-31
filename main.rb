require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'json'

get '/' do
  erb :home
end

get '/new' do
  erb :new
end

get '/friends' do
  conn = PG.connect(:dbname => 'friends', :host => 'localhost')
  sql_command = ('SELECT * FROM friend')
  @rows = conn.exec(sql_command)


  erb :friends
end


post '/create' do
  name = params[:name] || ''
  age = params[:age] || ''
  gender = params[:gender] || ''
  image = params[:image] || ''
  twitter = params[:twitter] || ''
  github = params[:github] || ''

    conn = PG.connect(:dbname => 'friends', :host => 'localhost')
    sql_command = "INSERT INTO friend(name, age, gender, image, twitter, github) VALUES('#{name}', '#{age}', '#{gender}', '#{image}', '#{twitter}', '#{github}')"
    conn.exec(sql_command)
    redirect '/'


end



# get ‘/’
# get ‘/new’
# get ‘/friends’
# post ‘/create’