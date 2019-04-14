require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_secret"
  end

  get "/" do
    erb :welcome
  end

  get '/signup' do
    if logged_in?
      redirect '/restaurants'
    else
      erb :'/users/create_user'
    end
  end
  post '/signup' do

    @username = params[:username]
    @password = params[:password]
    @email = params[:email]
    unless @username.empty? || @password.empty? || @email.empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/restaurants'
    else
      redirect '/signup'
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      user = User.find(session[:user_id])
    end
  end
end
