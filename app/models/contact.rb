class Contact < ActiveRecord::Base
  validates_uniqueness_of :email, :facebook_id
end
