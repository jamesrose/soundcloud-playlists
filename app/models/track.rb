class Track < ActiveRecord::Base
  
  # Attributes
  attr_accessor :uri
  attr_accessible :uri
  
  serialize :soundcloud

  # Assocations
  belongs_to :playlist
  
  # Valdiations
  validates :soundcloud, :playlist_id, presence: true
  
  # Callbacks
  before_validation :save_soundcloud_response
  
  # Save serialised response from SC w/ Track.
  def save_soundcloud_response
    client = Soundcloud.new(client_id: ENV['soundcloud_client_id'])
    response = client.get('/resolve', url: uri)
    self.soundcloud = response
  end

end