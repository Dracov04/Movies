class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :artist_id
      t.integer :album_id
      t.string :title
      t.integer :listeners
      t.string :video_url
      t.timestamps
    end
  end
end
