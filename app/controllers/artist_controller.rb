class ArtistController < ApplicationController
	def index
		@artists = Artist.order(name: :asc).page params[:page]
	end

	def show
		@artist = Artist.find params[:id]
	end
end
