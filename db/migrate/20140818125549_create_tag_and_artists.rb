class CreateTagAndArtists < ActiveRecord::Migration
  def change
    create_table :artists_tags do |t|
      t.belongs_to :artist
      t.belongs_to :tag
      t.timestamps
    end
  end
end