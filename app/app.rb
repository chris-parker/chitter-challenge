ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require 'sinatra/flash'
require_relative 'models/data_mapper_setup'

class Chitter < Sinatra::Base
  use Rack::MethodOverride
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  get '/' do
    erb(:home)
  end

  get '/new/user' do
    @user = User.new
    @title = "Sign up"
    erb(:newuser)
  end

  post '/new/user' do
    @user = User.new(username: params[:username],
                    email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb(:newuser)
    end
  end

  get '/sessions/new' do
    @title = "Log in"
    erb(:newsession)
  end

  post '/sessions' do
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/')
    else
      flash.now[:errors] = ['The username or password is incorrect']
      erb :'newsession'
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    flash.keep[:notice] = 'Signed out!'
    redirect to '/'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  run! if app_file == $0
end
