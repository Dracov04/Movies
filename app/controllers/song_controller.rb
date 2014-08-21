class SongController < ApplicationController
	def show
		@song = Song.find params[:id]
		
		@page = Nokogiri::HTML(open(@song.video_url))
		@noko = @page.css('div[class="wrapper"]').to_s.html_safe
	end
end
