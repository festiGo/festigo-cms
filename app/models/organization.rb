class Organization < ActiveRecord::Base
  include ImageModel
  mount_uploader :image, OrganizationImageUploader

  MIN_HEIGHT = Rails.configuration.route_profile_image_min_height
  MIN_WIDTH = Rails.configuration.route_profile_image_min_width

  attr_accessible :image, :name
  validates_presence_of :name
  after_update :crop_image

  has_many :users
end
