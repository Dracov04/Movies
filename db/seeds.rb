# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   Mayor.create(name: 'Emanuel', city: cities.first)

# SEARCH BY TITLE
			# require 'imdb'

			# search = Imdb::Search.new("Underworld")
			# movies = search.movies[0..10].collect{|mo| [mo.title, mo.plot, mo.poster, mo.year, mo.cast_members]}


			# movies.each do |a|
			#  my_movie = Movie.create(title: a[0], plot: a[1], poster: a[2], year: a[3])
			#  a[4].each do |imdb_member|
			#  	my_member = CastMember.find_or_create_by full_name: imdb_member
			#  	my_movie.cast_members << my_member
			#  end
			# end

# SEARCH BY TITLE AND 250

		#  search = Imdb::Search.new('a')
		#  @imdb = search.movies[0..20]
		#  # @imdb = Imdb::Top250.new.movies
		#  @movies = @imdb.collect do |imdb|
		#  	movie = Movie.find_or_create_by(title: imdb.title, plot: imdb.plot, poster: imdb.poster, year: imdb.year, trailer_url: imdb.trailer_url)
		#  	imdb.genres.each do |genre|
		#  		category = Category.find_or_create_by name: genre
		#  		movie.categories << category
		#  	end

		#  	imdb.cast_members.each do |imdb_member|	
		#  	 	my_member = CastMember.find_or_create_by full_name: imdb_member
 	#  	 		movie.cast_members << my_member
		#  	end
		#  end
		

# SEARCH BY TITLE SONG

		# @lastFM_search = LastFM::Track.search(:track => 'a')

		# @lastFM = @lastFM_search['results']['trackmatches']['track']

		# @songs = @lastFM.each do |track|
		# 	song = Song.find_or_create_by(title: track['name'], listeners: track['listeners'], video_url: track['url'])

		# 	@lastFM_search_artist = LastFM::Artist.get_info(:artist => track['artist'])

		# 	artist = Artist.find_or_create_by(name: track['artist'], info: @lastFM_search_artist['artist']['bio']['summary'])

		# 	song.artist = artist

		# 	if @lastFM_search_artist['artist']['tags']['tag']
		#  		@lastFM_search_artist['artist']['tags']['tag'].each do |tag|
		#  			tag_obj = Tag.find_or_create_by name: tag['name']
		#  			if artist.tags[3]
		#  				artist.tags
		#  			else
		#  				artist.tags << tag_obj
		#  			end
		#  		end
	 # 		end
	 # 		song.save
		#  end