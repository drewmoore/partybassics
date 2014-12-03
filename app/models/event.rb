class Event < ActiveRecord::Base
  mount_uploader :flyer, FlyerUploader
  has_many :purchases
end
