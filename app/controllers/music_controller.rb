class MusicController < ApplicationController

	def index
		@songs = Song.all.page params[:page]
	end

	def search_song
		@songs = Song.where(["lower(title) LIKE (?)",'%' + params[:title].downcase + '%'])
		@songs.page params[:page]
		if !@songs.empty?
			@songs
		else

			@lastFM_search = LastFM::Track.search(:track => params[:title])

			@lastFM = @lastFM_search['results']['trackmatches']['track']

			if @lastFM != nil
				@songs = @lastFM.inject(Array.new) do |all_songs, track|
					song = Song.find_or_create_by(title: track['name'], listeners: track['listeners'], video_url: track['url'])

					@lastFM_search_artist = LastFM::Artist.get_info(:artist => track['artist'])

					artist = Artist.find_or_create_by(name: track['artist'], info: @lastFM_search_artist['artist']['bio']['summary'])
					if artist != nil
						if song.artist 
						else
							song.artist = artist
						end
					end
					if @lastFM_search_artist['artist']['tags']
						if @lastFM_search_artist['artist']['tags']['tag']
					 		@lastFM_search_artist['artist']['tags']['tag'].each do |tag|
					 			tag_obj = Tag.find_or_create_by name: tag['name']
					 			if artist.tags.find_by name: tag_obj.name
					 			else
					 				artist.tags << tag_obj
					 			end
					 		end
				 		end
				 	end
			 		all_songs << song if song.save
			 		all_songs
		 		end
		 	end
		end
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
