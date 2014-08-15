class SongController < ApplicationController
	
	require 'rubygems'
	require 'nokogiri'
	require 'open-uri'
	   
	def search
		@search_song = LastFM::Track.search(:track => params[:title])
		@track_first = @search_song['results']['trackmatches']['track'][0]

		@page = Nokogiri::HTML(open(@track_first['url']))   
		@noko = @page.css('div[class="wrapper"]').to_s.html_safe
	end
end
