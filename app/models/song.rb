class Song < ActiveRecord::Base
	belongs_to :artist
	belongs_to :album
	validates :title, uniqueness: {message: "Error, there is a song with this title"}
end
