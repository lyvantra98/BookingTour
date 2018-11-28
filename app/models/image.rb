class Image < ApplicationRecord
  mount_uploader :image_link, ImageUploader
  belongs_to :tour
  scope :select_image, -> {select :id, :image_link}
end
