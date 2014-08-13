class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :plot  
      t.string :poster
      t.integer :year
      t.timestamps
    end
  end
end