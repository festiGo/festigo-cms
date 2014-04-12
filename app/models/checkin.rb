class Checkin < ActiveRecord::Base
  belongs_to :device
  belongs_to :route
  belongs_to :location
  belongs_to :device
  attr_accessible :stamp

  def checked_user
    self.device.user
  end
end
