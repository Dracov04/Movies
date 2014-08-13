class MoviesController < ApplicationController
	def index
		require 'kaminari'
		#@movies = Movie.last_created_movies(10).order(counter: :asc)
		@movies = Movie.all.order(counter: :asc).order(year: :desc).page params[:page]
	end

	def show
		@movies = Movie.find params[:id]
		rescue
			@movies = Movie.last_created_movies(10)
	  		render 'error', layout: 'errorlayout'
	end

	def principal
		@movies = Movie.last_created_movies(10)
	end

	def edit
		@movie = Movie.find params[:id]
	end

	def update
		@movie = Movie.find params[:id]

		if @movie.update_attributes movie_params
			redirect_to action: 'index', controller: 'movies', movie_id: @movie.id
		else
			render 'edit'
		end
	end

	def destroy
		@movie = Movie.find params[:id]
		@movie.destroy
		redirect_to action: 'index', controller: 'movies', movie_id: @movie.id
	end

	def reduce_counter
		@movie = Movie.find params[:movie_id]

		unless @movie.update(counter: @movie.counter - 1)
		end

		redirect_to movies_path
	end

	def increment_counter
		@movie = Movie.find params[:movie_id]

		unless @movie.update(counter: @movie.counter + 1)
		end

		redirect_to movies_path
	end

	def movie_params
		params.require(:movie).permit(:title, :plot, :poster, :year)
	end

	def search
		search = Imdb::Search.new params[:qwery]
		@imdb = search.movies[0..10]

		@movies = @imdb.collect do |imdb|
			movie = Movie.find_or_create_by(title: imdb.title, plot: imdb.plot, poster: imdb.poster, year: imdb.year)
			imdb.genres.each do |genre|
				category = Category.find_or_create_by name: genre
				movie.categories << category
			end

			 imdb.cast_members.each do |imdb_member|	
			 	my_member = CastMember.find_or_create_by full_name: imdb_member
 		 		movie.cast_members << my_member
			 end
			movie
		end
		#.collect{|mo| [mo.title, mo.plot, mo.poster, mo.year, mo.cast_members]}
		render 'index'
	end
end


