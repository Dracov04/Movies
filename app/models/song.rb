class Song < ActiveRecord::Base
	belongs_to :artist
	belongs_to :album
	validates :title, uniqueness: {message: "Error, there is a song with this title"}
	validates :title, presence: {message: "Error, there isn´t any title"}
	validates :listeners, presence: {message: "Error, there isn´t any listeners"}
	validates :video_url, presence: {message: "Error, there isn´t any video_url"}
	paginates_per 12
end
