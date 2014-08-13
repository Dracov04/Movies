class AddCounterToMovies < ActiveRecord::Migration
  def change
  	add_column :movies, :counter, :integer, default: 0
  end
end
