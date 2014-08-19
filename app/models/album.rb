class Album < ActiveRecord::Base
	has_many :songs
	belongs_to :artist

	validates :title, uniqueness: {message: "Error, there is an album with this title"}
end
