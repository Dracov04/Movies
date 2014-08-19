class MusicController < ApplicationController
	
	require 'rubygems'
	require 'nokogiri'
	require 'open-uri'

	def index
		@album = LastFM::Album.get_info(:artist => "Red Hot Chili Peppers", :album => "Mother's Milk")
		@al = @album['album']
	end

	def search_song

		# @songs = Song.where(["lower(title) LIKE (?)",'%' + params[:title].downcase + '%'])

		# @song = @songs.first

		# @page = Nokogiri::HTML(open(@song.video_url))
		# @noko = @page.css('div[class="wrapper"]').to_s.html_safe


		@lastFM_search = LastFM::Track.search(:track => params[:title])

		@lastFM = @lastFM_search['results']['trackmatches']['track']

		@songs = @lastFM.map do |track|
			song = Song.find_or_create_by(title: track['name'], listeners: track['listeners'], video_url: track['url'])

			@lastFM_search_artist = LastFM::Artist.get_info(:artist => track['artist'])

			artist = Artist.find_or_create_by(name: track['artist'], info: @lastFM_search_artist['artist']['bio']['summary'])

			song.artist = artist

			if @lastFM_search_artist['artist']['tags']['tag']
		 		@lastFM_search_artist['artist']['tags']['tag'].each do |tag|
		 			tag_obj = Tag.find_or_create_by name: tag['name']
		 			if artist.tags[3]
		 				artist.tags
		 			else
		 				artist.tags << tag_obj
		 			end
		 		end
	 		end
	 		song.save
	 		song
		 end
		 @song = @songs.first

		 @page = Nokogiri::HTML(open(@song.video_url))
		 @noko = @page.css('div[class="wrapper"]').to_s.html_safe
	end

	def search_category
		sql = ""
 		params[:tag].each do |tag|
 		sql += ' OR ' if sql != ""
 			sql += "lower(name) LIKE ('%"+ tag.downcase + "%') "
 		end

		@tags = Tag.where(sql)

		# @busqueda_artistas = LastFM::Tag.get_top_artists(:tag => params[:category] )
		# @printar = @busqueda_artistas['topartists']['artist']
	end

	def random_songs
 		@song = Song.find_by_id(rand(Song.count))
		@page = Nokogiri::HTML(open(@song.video_url))
		@noko = @page.css('div[class="wrapper"]').to_s.html_safe
 	end
end
