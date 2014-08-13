class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :movie_id
      t.string :reviewer
      t.text :content
      t.timestamps
    end
  end
end