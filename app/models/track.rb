class Track < ActiveRecord::Base
  attr_accessor :uri
  attr_accessible :uri

  # Assocations
  belongs_to :playlist
  
  # Valdiations
  validates :soundcloud_id, :playlist_id, presence: true
  
  before_validation :set_soundcloud_id_and_title

  def set_soundcloud_id_and_title
    client = Soundcloud.new(client_id: ENV['soundcloud_client_id'])
    response = client.get('/resolve', url: uri)

    self.soundcloud_id = response.id
    self.soundcloud_title = response.title
  end

end