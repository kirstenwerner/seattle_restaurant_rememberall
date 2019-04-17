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

  get '/restaurants/new' do
    if logged_in?
      erb :'/restaurants/new'
    else
      redirect '/login'
    end
  end

  post '/restaurants' do
    @user = User.find(session[:user_id])
    @cuisine = Cuisine.find_or_create_by(params[:cuisine])
    @neighborhood = Neighborhood.find_or_create_by(params[:neighborhood])

    unless params[:restaurant].empty? || params[:cuisine].empty? || params[:neighborhood].empty?
    Restaurant.create(name: params[:restaurant][:name], user_id: @user.id, cuisine_id: @cuisine.id, neighborhood_id: @neighborhood.id)
      redirect "/users/#{@user.slug}"
    else
      redirect '/restaurants/new'
    end
  end

  post '/add' do
    binding.pry
    redirect '/add'
  end

  get '/add' do
    binding.pry
    redirect "/users/#{@user.slug}"
  end

  get '/all' do
    erb :'/restaurants/all'
  end

  get '/by_cuisine' do
    erb :'/restaurants/by_cuisine'
  end

  post '/by_cuisine' do
    @cuisine = Cuisine.find_by(name: params[:cuisine_selection])
    if @cuisine
      @restaurants = Restaurant.where(cuisine_id: @cuisine.id)

      redirect "/by_cuisine/#{@cuisine.name}"
    else
      redirec "/by_cuisine"
    end 
  end

  get "/by_cuisine/:cuisine" do
    @cuisine = Cuisine.find_by(name: params[:cuisine])
    @user = User.find(session[:user_id])
    erb :'/restaurants/by_cuisine_show'
  end

  get '/by_neighborhood' do
    erb :'/restaurants/by_neighborhood'
  end

  post '/by_neighborhood' do
    @neighborhood = Neighborhood.find_by(name: params[:neighborhood_selection])
    if @neighborhood
      @restaurants = Restaurant.where(neighborhood_id: @neighborhood.id)

      redirect "/by_neighborhood/#{@neighborhood.name}"
    else
      redirect "/by_neighborhood"
    end
  end

  get "/by_neighborhood/:neighborhood" do
    @neighborhood = Neighborhood.find_by(name: params[:neighborhood])
    @user = User.find(session[:user_id])
    erb :'/restaurants/by_neighborhood_show'
  end

  get '/restuarants/:id' do
    if logged_in?
      @restaurant = Restaurant.find(params[:id])
      erb :'/restaurants/show_restuarant'
    else
      redirect '/login'
    end
  end

  post '/restuarants/:id' do
    redirect "/restaurants/#{param[id]}/edit"
  end

  post '/restaurants/:id/edit' do
    @restaurant = Restaurant.find(params[:id])
    erb :'/restaurants/edit'
  end

  get '/restuarants/:id/edit' do
    if logged_in?
      @restaurant = Restaurant.find(params[:id])
      erb :'/restuarants/edit'
    else
      redirect '/login'
    end
  end

  patch '/restaurants/:id' do
    unless params[:restaurant][:name].empty?
      @user = User.find(session[:user_id])
      @restaurant = Restaurant.find(params[:id])
      @cuisine = Cuisine.find_or_create_by(name: params[:restaurant][:cuisine])
      @neighborhood = Neighborhood.find_or_create_by(name: params[:restaurant][:neighborhood])
      @restaurant.update(name: @restaurant.name, cuisine_id: @cuisine.id, neighborhood_id: @neighborhood.id)
      redirect "/users/#{@user.slug}"
    else
      redirect "/restaurants/#{params[:id]}/edit"
    end
  end

  delete '/restaurants/:id' do
    if logged_in?
      @restaurant = Restaurant.find(params[:id])
      if @restaurant.user.id == session[:user_id]
        @restaurant.destroy
      end
      @user = User.find(session[:user_id])
      redirect "/users/#{@user.slug}"
    else
      redirect '/login'
    end
  end
end
