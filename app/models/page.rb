class Page < ActiveRecord::Base
  validates_uniqueness_of :controller, :scope => :action
  has_and_belongs_to_many :contents, :join_table => :contents_pages
  has_and_belongs_to_many :graphics, :join_table => :graphics_pages

  def get_graphics
    graphics = {}
    self.graphics.each do |g|
      graphics[g.identifier] = g
    end
    return graphics
  end

  def get_contents
    contents = {}
    self.contents.each do |c|
      contents[c.identifier] =c
    end
    return contents
  end

end
