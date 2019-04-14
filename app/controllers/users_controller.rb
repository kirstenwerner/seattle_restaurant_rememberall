class UsersController < ApplicationController

   get '/login' do
      if logged_in?
         redirect '/restaurants'
      else
         erb :'/users/login'
      end
   end

   post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
         session[:user_id] = @user.id
         redirect '/restaurants'
      else
         redirect '/login'
      end
   end

   post '/logout' do
      redirect '/logout'
   end

   get '/logout' do
      if logged_in?
         session.clear
         redirect '/login'
      else
         redirect '/login'
      end
   end

   get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
   end
end
