# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   Mayor.create(name: 'Emanuel', city: cities.first)
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
		# search = Imdb::Search.new('a')
		# @imdb = search.movies[0..20]
		@imdb = Imdb::Top250.new.movies
		@movies = @imdb.collect do |imdb|
			movie = Movie.find_or_create_by(title: imdb.title, plot: imdb.plot, poster: imdb.poster, year: imdb.year, trailer_url: imdb.trailer_url)
			imdb.genres.each do |genre|
				category = Category.find_or_create_by name: genre
				movie.categories << category
			end

			imdb.cast_members.each do |imdb_member|	
			 	my_member = CastMember.find_or_create_by full_name: imdb_member
 		 		movie.cast_members << my_member
			end
		end