class Market < ActiveRecord::Base
  belongs_to :user
  has_many :favorite
  #mount_uploader :image, ImageUploader
end
