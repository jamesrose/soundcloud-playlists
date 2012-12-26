class AddSoundcloudToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :soundcloud, :text
    remove_column :tracks, :soundcloud_title
    remove_column :tracks, :soundcloud_id
  end
end
