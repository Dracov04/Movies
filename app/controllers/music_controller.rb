class MusicController < ApplicationController
	
	require 'rubygems'
	require 'nokogiri'
	require 'open-uri'

	def index
		@album = LastFM::Album.get_info(:artist => "Red Hot Chili Peppers", :album => "Mother's Milk")
		@al = @album['album']
	end

	def search_song
		@search_song = LastFM::Track.search(:track => params[:title])
		@track_first = @search_song['results']['trackmatches']['track'][0]

		@page = Nokogiri::HTML(open(@track_first['url']))   
		@noko = @page.css('div[class="wrapper"]').to_s.html_safe
	end

	def search_category
		@busqueda_artistas = LastFM::Tag.get_top_artists(:tag => params[:category] )
		@printar = @busqueda_artistas['topartists']['artist']
	end
end
