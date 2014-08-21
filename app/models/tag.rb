class Tag < ActiveRecord::Base
	has_and_belongs_to_many :artists
	validates :name, presence: {message: "Error, there isn´t any name"}
end
