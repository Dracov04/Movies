class CategoriesController < ApplicationController
	require 'kaminari'
	def index
		@categories = Category.all.order(name: :asc)
	end

	def show
		@categories = Category.find params[:id]
	end
end