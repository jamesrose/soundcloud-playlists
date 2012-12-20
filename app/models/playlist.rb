class Playlist < ActiveRecord::Base
  # Attributes
  attr_accessible :description, :title
  
  # Associations
  belongs_to :user
  
  # Validations
  validates :description, :title, :user, presence: true
end
