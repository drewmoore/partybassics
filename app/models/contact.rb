class Contact < ActiveRecord::Base
  validates_uniqueness_of :email, :if => '!email.empty?'
  validates_uniqueness_of :facebook_id, :if => '!facebook_id.empty?'
end
