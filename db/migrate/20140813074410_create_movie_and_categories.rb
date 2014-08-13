class CreateMovieAndCategories < ActiveRecord::Migration
  def change
    create_table :categories_movies do |t|
      t.belongs_to :movie
      t.belongs_to :category
    end
  end
end