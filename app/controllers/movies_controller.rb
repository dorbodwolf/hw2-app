class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.order(params[:sort_by])
    #@movies = Movie.order('release_date')
     	
    @all_ratings = Movie.ratings_list
    redirect = false

    if params.has_key?:sort
        #debugger
        (params["sort_by"].nil?)?(@ratings = []):(@ratings = params["sort_by"])
        @movies = Movie.order(params[:sort_by]).find_all_by_rating(@ratings)       #:all,:conditions=>{"rating"=>@rating}, :order=>params[:sort])
        @sort = params[:sort_by]
    else

        @ratings = params["ratings"].keys if params.has_key?"ratings"
        @movies = Movie.find_all_by_rating(@ratings)
    end 

    if params.has_key?"ratings"
        @ratings = params["ratings"].keys 
    else
      @ratings = []
    end   

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end  

end
