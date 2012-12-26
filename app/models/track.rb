class Track < ActiveRecord::Base
  
  # Attributes
  attr_accessor :uri
  attr_accessible :uri
  
  serialize :soundcloud

  # Assocations
  belongs_to :playlist
  
  # Valdiations
  validates :soundcloud, :playlist_id, presence: true
  validate :track_should_be_embeddable

  # Callbacks
  before_validation :save_soundcloud_response
    
  # Save serialised response from SC w/ Track.
  def save_soundcloud_response
    client = Soundcloud.new(client_id: ENV['soundcloud_client_id'])
    response = client.get('/resolve', url: uri)
    self.soundcloud = response
  end
  
  private
  
  def track_should_be_embeddable
    unless soundcloud.embeddable_by == 'all'
      errors.add(:base, 'track is not embeddable')
      false
    end
  end

end