class MusicController < ApplicationController
	def index
		@album = LastFM::Album.get_info(:artist => "Red Hot Chili Peppers", :album => "Mother's Milk")
		@al = @album['album']

		@busqueda_artistas = LastFM::Tag.get_top_artists(:tag => "hip hop")
		@printar = @busqueda_artistas['topartists']['artist']
	end
end
