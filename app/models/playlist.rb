class Playlist < ActiveRecord::Base
  # Attributes
  attr_accessible :description, :title
  
  # Associations
  belongs_to :user
  has_many :tracks
  
  # Validations
  validates :description, :title, :user, presence: true
end
