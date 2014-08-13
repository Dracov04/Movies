class ReviewsController < ApplicationController
	def new
		@movie = Movie.find params[:movie_id]
		@review = @movie.reviews.new
	end

	def index
		@movie = Movie.find params[:movie_id]
	end

	def edit
		@movie = Movie.find params[:movie_id]
		@review = @movie.reviews.find params[:id]
	end

	def update
		@movie = Movie.find params[:movie_id]
		@review = @movie.reviews.find params[:id]

		if @review.update_attributes review_params
			redirect_to action: 'index', controller: 'reviews', movie_id: @movie.id
		else
			render 'edit'
		end
	end

	def create
		@movie = Movie.find params[:movie_id]
		@review = @movie.reviews.new review_params

		if @review.save
			redirect_to action: 'index', controller: 'reviews', movie_id: @movie.id
		else
			render 'new'
		end
	end

	private

	def review_params
		params.require(:review).permit(:reviewer, :content)
	end
end
