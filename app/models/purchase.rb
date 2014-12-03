class Purchase < ActiveRecord::Base
  belongs_to :event
  validates :conf_num, uniqueness: true
end
