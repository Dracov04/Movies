class CastMember < ActiveRecord::Base
	has_and_belongs_to_many :movies
	validates :full_name, presence: {message: "Error, there isn't any name"}
	validates :full_name, uniqueness: {message: "Error, there is an actor with this name"}
	paginates_per 20
end
