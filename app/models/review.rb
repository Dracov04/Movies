class Review < ActiveRecord::Base
	belongs_to :movie
	validates :reviewer, presence: {message: "Error, there isn't any reviewer"}
	validates :content, presence: {message: "Error, there isn't any content"}
end