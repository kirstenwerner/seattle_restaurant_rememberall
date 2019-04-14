class RestaurantsController < ApplicationController

  get '/restaurants' do
    if logged_in?
      @user = current_user
      erb :'/restaurants/restaurants'
    else
      redirect '/login'
    end
  end

  post '/restaurants/new' do
    if logged_in?
      redirect '/restaurants/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/restaurants/new'
    else
      redirect '/login'
    end
  end

  post '/restaurants' do
    @user = User.find(session[:user_id])
    unless params[:restaurant][:name].empty?
      @user.restaurants << Restaurant.new(params[:restaurant])
      redirect "/users/#{@user.slug}"
    else
      redirect '/restaurants/new'
    end
  end

  get '/restuarants/:id' do
    if logged_in?
      @restaurant = Restaurant.find(params[::id])
      erb :'/restaurants/show_restuarant'
    else
      redirect '/login'
    end
  end

  post '/restuarants/:id' do
    redirect "/restaurants/#{param[id]}/edit"
  end

  get '/restuarants/:id/edit' do
    if loggen_in?
      @restaurant = Restaurant.find(params[:id])
      erb :'/restuarants/edit_restaurant'
    else
      redirect '/login'
    end
  end

  patch '/restaurants/:id' do
    unless params[:restuarant][:name].empty?
      @restuarant = Restaurant.find(params[:id])
      @restuarant.update(params[:restaurant])
      redirect "/restaurants/#{@restuarant.id}"
    else
      redirect "/restuarants/#{params[:id]}/edit"
    end
  end

  delete '/restuarants/:id' do
    if logged_in?
      @restuarant = Restaurant.find(params[:id])
      if @restuarant.user.id == session[:user_id]
        @restuarant.destroy
      end
    else
      redirect '/login'
    end 
  end

end
