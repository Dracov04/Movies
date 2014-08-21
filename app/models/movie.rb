class Movie < ActiveRecord::Base
	has_and_belongs_to_many :cast_members
	has_many :reviews
	has_and_belongs_to_many :categories

	validates :year, presence: {message: "Error, there isn't any year"}
	validates :plot, presence: {message: "Error, there isn't any plot"}
	validates :poster, presence: {message: "Error, there isn't any poster"}
	validates :trailer_url, presence: {message: "Error, there isn't any trailer url"}
	validates :title, uniqueness: {message: "Error, there is a movie with this title"}

	scope :search, ->(title) {
		where(["lower(title) LIKE (?)","%#{title.downcase}%"])
	}

	def self.last_created_movies(n)
		movie = order(created_at: :desc).limit(n)
		unless movie.present?
			raise
	ActiveRecord::RecordNotFound.new("couldn´t find movie with id=#{id}")
	end
	movie
	end

	paginates_per 12
end
