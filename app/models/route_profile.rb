class RouteProfile < ActiveRecord::Base
  include ImageModel
  mount_uploader :image, RouteProfileImageUploader

  default_scope order('priority DESC')

  MIN_HEIGHT = Rails.configuration.route_profile_image_min_height
  MIN_WIDTH = Rails.configuration.route_profile_image_min_width

  attr_accessible :description, :image, :name, :translations_attributes,:city, :city_id, :priority, :organization_id, :date_start, :date_end

  belongs_to :city
  has_many :routes, :dependent => :destroy
  belongs_to :organization

  translates :name, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations
  validates_presence_of :name, :image
  after_update :crop_image
  validate :validate_minimum_image_size

  scope :in_cities, ->(city_ids) { where("city_id IN (?)", city_ids) }
  scope :in_city, ->(city_id) {
    where(:city_id => city_id)
  }

  def icon_data
    Base64.encode64(open(self.icon.to_s) { |io| io.read }) unless self.icon.to_s.blank?
  end


  class Translation
    attr_accessible :locale, :name
    validates_presence_of :name
  end

  def published_routes
    routes.where("published_key IS NOT NULL")
  end

  def active?
    Date.today <= self.date_end && Date.today >= self.date_start
  end

end
