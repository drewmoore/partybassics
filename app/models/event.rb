class Event < ActiveRecord::Base
  mount_uploader :flyer, FlyerUploader
end
