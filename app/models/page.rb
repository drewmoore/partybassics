class Page < ActiveRecord::Base
  validates_uniqueness_of :controller, :scope => :action
  has_and_belongs_to_many :contents, :join_table => :contents_pages
  has_and_belongs_to_many :graphics, :join_table => :graphics_pages
end
