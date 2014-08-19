class Artist < ActiveRecord::Base
	has_many :songs
	has_many :albums
	has_and_belongs_to_many :tags

	validates :name, uniqueness: {message: "Error, there is an artist with this name"}
end
