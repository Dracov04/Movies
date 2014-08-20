class MoviesController < ApplicationController
	before_action :set_movie, only: [:edit, :update, :destroy, :increment_counter, :reduce_counter]

	def index
		@movies = Movie.all.order(counter: :asc).order(year: :desc).page params[:page]
	end

	def show
		@movie = Movie.find_by(id: params[:id])

		unless @movie.present?
			@movies = Movie.last_created_movies(10)

	  		render 'error', layout: 'errorlayout'
		end
	end

	def principal
		@movies = Movie.last_created_movies(10)
	end

	def edit
		
	end

	def update
		if @movie.update_attributes movie_params
			redirect_to action: 'index', controller: 'movies', movie_id: @movie.id
			#redirect_to @movie
			#redirect_to movies_path
		else
			render 'edit'
		end
	end

	def destroy
		@movie.destroy
		redirect_to action: 'index', controller: 'movies', movie_id: @movie.id
	end

	def reduce_counter
		@movie.update(counter: @movie.counter - 1)

		redirect_to movies_path
	end

	def increment_counter
		@movie.update(counter: @movie.counter + 1)

		redirect_to movies_path
	end

	def search
		@movies = Movie.search(params[:title]).page params[:page]

		if @movies != []
			@movies
		else
		 	search = Imdb::Search.new params[:title]
		 	@imdb = search.movies[0..10]

		 	@movies = @imdb.inject(Array.new) do |all_movies, imdb|
		 		movie = Movie.find_or_create_by(title: imdb.title, plot: imdb.plot, poster: imdb.poster, year: imdb.year)
		 		imdb.genres.each do |genre|
		 			category = Category.find_or_create_by name: genre
		 			movie.categories << category
		 		end

		 		 imdb.cast_members.each do |imdb_member|	
		 		 	my_member = CastMember.find_or_create_by full_name: imdb_member
	  		 		movie.cast_members << my_member
		 		 end
		 		all_movies << movie if movie.save
		 		all_movies
		 	end
		 	@movies
		end
	end

	def search_category
		@categories = Category.where(name: params[:category]).page(params[:page])
	end

 	def random_movies
 		@movie = Movie.find_by_id(rand(Movie.count))
 	end

 	private
 	def set_movie
 		@movie = Movie.find params[:id]
 	end

 	def movie_params
		params.require(:movie).permit(:title, :plot, :poster, :year)
	end
end