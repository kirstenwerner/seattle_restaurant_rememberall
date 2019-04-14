class RestaurantsController < ApplicationController

  get '/restaurants' do
    if logged_in?
      @user = current_user
      erb :'/restaurants/restaurants'
    else
      redirect '/login'
    end
  end

  get '/restaurants/new' do
    'Hello World'
    erb :'/restaurants/new'
  end

  post '/restaurants/new' do
    'hello world'
  end

end
