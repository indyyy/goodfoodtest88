     
require 'sinatra'
# require 'sinatra/reloader'
require 'pg'
require 'pry'


def run_sql(sql)
  conn = PG.connect(dbname: 'goodfoodhunting')
  result = conn.exec(sql)
  conn.close
  return result
end

require_relative 'db_config'
require_relative 'models/dish'
require_relative 'models/comment'
require_relative 'models/user'
require_relative 'models/like'

enable :sessions

helpers do

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    # double negation for current_user to boolean vs. if then true and false
    !!current_user #user object or nil
  end
end

get '/' do
  @dishes = Dish.all
  erb :index, layout: true

end

get '/about' do
  return 'me me me'
end


# getting the form
get '/dishes/new' do
  erb :new
end

# showsing single dish by id
get '/dishes/:id' do
  

  @dish=Dish.find( params[:id] ) # 'find' is always by id 
  @comments= @dish.comments
  erb :dish_detail
end


# create a dish
post '/dishes' do
  
  dish = Dish.new
  dish.name = params[:name]
  dish.image_url = params[:image_url]
  dish.save

  # get post redirect
  redirect '/' # needs to a route - because its making a request
  # get safe and harmless, post danger
end

# delete a dish
delete '/dishes/:id' do

  #sql = "DELETE FROM dishes WHERE id = #{ params[:id] };"
  #run_sql(sql)

  dish = Dish.find( params[:id])
  dish.destroy
  
  redirect '/'
  "danger!!!!"
end

get '/dishes/:id/edit' do
  #result = run_sql("SELECT * FROM dishes WHERE id = #{ params[:id] #}")
  #@dish = result.first

  @dish = Dish.find(params[:id])
  erb :edit 
end

put '/dishes/:id' do
  redirect '/login' unless logged_in?
  
   
  dish = Dish.find(params[:id])
  dish.name = params[:name]
  dish.image_url = params[:image_url]
  dish.save

  redirect "/dishes/#{ params[:id] }"
  # run the sql
  # redirect
end


post '/comments' do
  
  redirect '/login' unless logged_in?

  comment = Comment.new
  comment.content = params[:content]
  comment.dish_id = params[:dish_id]
  comment.save


  redirect "/dishes/#{ params[:dish_id]}"
end


get '/login' do
  erb :login
end

post '/session' do
  # grab email and password
  # find the user by email
  user = User.find_by(email: params[:email])
  # authenticate user with password
  if user && user.authenticate(params[:password])
  # create new session
  session[:user_id] = user.id
  # redirect to secret page
  redirect '/'
  else 
    erb :login
  end
end

delete '/session' do
  #delete the session
  session[:user_id] = nil
  #redirect to /login
  redirect '/login'
end

post '/likes' do
  redirect '/login' unless logged_in?
  # insert a record into the likes table
  # creating a like 
  like = Like.new
  like.dish_id = params[:dish_id]
  like.user_id = current_user.id
  like.save

  redirect "/dishes/#{params[:dish_id]}"
end





