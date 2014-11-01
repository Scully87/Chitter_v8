require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'

require './lib/user'
require './lib/greet'

require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash 
set :partial_template_engine, :erb

get '/' do
	@users = User.all
	@greets = Greet.all 
	erb :index
end

get '/api/users' do
	content_type :json
	users = User.all
	p users.to_json
	return users.to_json
end

get '/api/peeps' do
	content_type :json
	greets = Greet.all
	p greets.to_json
	return greets.to_json
end

post '/greets' do
	@current_user =
	@greet = Greet.create(body: params[:body],
						  user_name: params[:user_name],
						  name: params[:name])
	@greet.save
	redirect to '/'
end

# get '/users/new' do
# 	@user = User.new
# 	erb :"users/new"
# end

post '/users' do
	@user = User.create(
					user_name: params[:user_name],
					name: params[:name],
					email: params[:email],
					password: params[:password],
					password_confirmation: params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect to '/'
	else
		flash[:errors] = ["Please fill in all the sign up fields"]
		redirect to '/'
	end
end

# get '/sessions/new' do
# 	erb :"sessions/new"
# end

post '/sessions' do
	user_name, password = params[:user_name], params[:password]
	user = User.authenticate(user_name, password)
	if user
		session[:user_id] = user.id
		redirect to('/')
	else
		flash[:errors] = ["The User Name or Password is incorrect"]
		redirect to('/')
	end
end	

delete '/sessions' do
	flash[:notice] = "See you soon!"
	session[:user_id] = nil
	redirect to ('/')
end