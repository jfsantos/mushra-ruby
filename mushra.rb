require 'sinatra'
require 'json'
require 'uri'

set :static, true
set :public_folder, 'mushraJS'

get '/' do
  redirect 'index.html'
end

post '/submit' do
  ratings_txt = URI.unescape(request.body.read.to_s)
  ratings_json = JSON.parse(ratings_txt)
  user_email = ratings_json['email'];
  f = File.open('results/'+Digest::MD5::hexdigest(user_email),'w')
  f.puts(ratings_json.to_s)
  f.close
  content_type 'application/json'
  {:error => "false",:message => "Data is saved!"}.to_json
end
