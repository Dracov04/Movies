class Category < ActiveRecord::Base
	has_and_belongs_to_many :movies
	validates :name, uniqueness: {message: "Error, there is a category with this title"}
end
