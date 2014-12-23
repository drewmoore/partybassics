class Visitor < ActiveRecord::Base
  validates_uniqueness_of :ip
  has_and_belongs_to_many :contacts, :join_table => :contacts_visitors
end
