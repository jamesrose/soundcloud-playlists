class AddSoundCloudTitleToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :soundcloud_title, :string
  end
end
