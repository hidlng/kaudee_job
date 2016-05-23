class Image < ActiveRecord::Base
	mount_uploader :img, ImageUploader
end
