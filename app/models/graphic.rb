class Graphic < ActiveRecord::Base
  validates_format_of :identifier, with: /\A^\S+$\z/, on: :create
  validates_uniqueness_of :identifier
  has_and_belongs_to_many :pages, :join_table => :graphics_pages
  mount_uploader :image, ImageUploader
end
