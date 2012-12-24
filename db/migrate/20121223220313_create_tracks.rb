class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :soundcloud_id
      t.integer :playlist_id

      t.timestamps
    end
  end
end
