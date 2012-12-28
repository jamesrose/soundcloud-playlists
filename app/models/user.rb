class User < ActiveRecord::Base
  
  # Attributes
  attr_accessible :access_token, :soundcloud_id
  
  # Associations
  has_many :playlists, dependent: :destroy
  has_many :tracks, through: :playlists
  
  # Validations
  validates :access_token, :soundcloud_id, presence: true
  
  # Find or create a new user by +soundcloud_id+ and create
  # an initial 'favourites' playlist to get started.
  def self.find_or_create_by(options)
    user = where(soundcloud_id: options[:soundcloud_id])
    return user.first if user.any?
    user = create(options)
    user.playlists.create(title: 'My Favourites', description: 'My all-time favourites')
  end
  
  # Accessor to SC API
  def client
    Soundcloud.new(access_token: access_token)
  end
end
