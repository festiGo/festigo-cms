class Organization < ActiveRecord::Base
  include ImageModel
  mount_uploader :image, OrganizationImageUploader

  MIN_HEIGHT = Rails.configuration.route_profile_image_min_height
  MIN_WIDTH = Rails.configuration.route_profile_image_min_width

  attr_accessible :image, :name
  validates_presence_of :name
  after_update :crop_image
  validates :name, :uniqueness => true

  has_many :users
  has_many :routes
  has_many :route_profiles

  def self.manageable_by_user(user)
    if user.is_admin?
      return Organization.all
    else
      return [user.organization]
    end
  end
end
